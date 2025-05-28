import FirebaseFirestore
import Combine

class ChatSessionObserver: ObservableObject {
    @Published var representativeId: String? = nil
    @Published var isActive: Bool = true
    private var listener: ListenerRegistration?

    func startListening(chatId: String) {
        let db = Firestore.firestore()
        listener = db.collection("chats").document(chatId).addSnapshotListener { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                print("Error listening chat session: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            DispatchQueue.main.async {
                self?.representativeId = data["representativeId"] as? String ?? ""
                self?.isActive = data["isActive"] as? Bool ?? true
            }
        }
    }
    
    deinit {
        listener?.remove()
    }
}
