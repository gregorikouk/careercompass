import Foundation
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import FirebaseFirestore

class AuthViewModel: NSObject, ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var error: String?

    private var currentNonce: String?

    override init() {
        super.init()
        self.user = Auth.auth().currentUser
    }

    func signIn(email: String, password: String) {
        isLoading = true
        error = nil
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            DispatchQueue.main.async {
                self.isLoading = false
                if let err = err {
                    self.error = err.localizedDescription
                } else {
                    self.user = result?.user
                }
            }
        }
    }

//    func register(email: String, password: String) {
//        isLoading = true
//        error = nil
//        Auth.auth().createUser(withEmail: email, password: password) { result, err in
//            DispatchQueue.main.async {
//                self.isLoading = false
//                if let err = err {
//                    self.error = err.localizedDescription
//                } else if let user = result?.user {
//                    self.user = user
//                    // Αποθήκευση quizResult = 0 στο Firestore
//                    let db = Firestore.firestore()
//                    db.collection("users").document(user.uid).setData([
//                        "quizResult": 0,
//                        "email": email
//                    ], merge: true)
//                }
//            }
//        }
//    }
    
    func register(email: String, password: String) {
        isLoading = true
        error = nil
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            DispatchQueue.main.async {
                self.isLoading = false
                if let err = err {
                    self.error = err.localizedDescription
                } else if let user = result?.user {
                    self.user = user
                    
                    // Δημιουργούμε το document με default quizResult = 0
                    let db = Firestore.firestore()
                    db.collection("users").document(user.uid).setData([
                        "quizResult": 0
                    ]) { error in
                        if let error = error {
                            print("Error creating user document: \(error.localizedDescription)")
                        } else {
                            print("User document created with default quizResult 0")
                        }
                    }
                }
            }
        }
    }
    
    func resetPassword(email: String) {
        isLoading = true
        error = nil
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.error = error.localizedDescription
                } else {
                    self.error = "Reset link sent to your email."
                }
            }
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        user = nil
    }

    // MARK: - Sign In with Apple

    func handleAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
        let nonce = randomNonceString()
        currentNonce = nonce
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
    }

    func handleAppleCompletion(_ authResults: Result<ASAuthorization, Error>) {
        switch authResults {
        case .success(let auth):
            guard let appleIDCredential = auth.credential as? ASAuthorizationAppleIDCredential else {
                error = "Invalid AppleID credentials"
                return
            }

            guard let nonce = currentNonce else {
                error = "Missing nonce"
                return
            }

            guard let appleIDToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                error = "Unable to fetch identity token"
                return
            }

            let credential = OAuthProvider.credential(
                providerID: AuthProviderID.apple,
                idToken: idTokenString,
                rawNonce: nonce,
                accessToken: nil
            )

            isLoading = true
            Auth.auth().signIn(with: credential) { (authResult, error) in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let error = error {
                        self.error = error.localizedDescription
                    } else {
                        self.user = authResult?.user
                    }
                }
            }

        case .failure(let error):
            self.error = error.localizedDescription
        }
    }

    // MARK: - Helpers

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }

    private func randomNonceString(length: Int = 32) -> String {
        let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms = (0..<16).map { _ in UInt8.random(in: 0...255) }
            for random in randoms {
                if remainingLength == 0 { break }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }
}
