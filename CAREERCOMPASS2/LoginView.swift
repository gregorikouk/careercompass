import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    
    @State var bg_color = Color("background")
    @State var dblue = Color("dblue")
    @State var lblue = Color("lblue")

    var body: some View {
        ZStack {
            bg_color
                .ignoresSafeArea()
            VStack(spacing: 0) {
                
                Text("CAREERCOMPASS")
                    .font(.title)
                    .fontWeight(.heavy)
                    .scaleEffect(x: 1.0, y: 1.05)
                    .foregroundStyle(.dblue)
                    .padding(.bottom, 100)
                
            
                HStack {
                    Image("account")
                        .resizable()
                        .opacity(0.4)
                        .frame(width: 20, height: 18)
                        .padding(.leading, 3)
                        
                    
                    TextField("Email", text: $email)
                        .font(.system(size: 16, weight: .bold)) // κείμενο bold
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                }
                .frame(height: 44)
                .padding(.horizontal)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(color: Color("dblue").opacity(0.4), radius: 1, x: 0.5, y: 2)
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                        .padding(.leading, 6)
                    
                    SecureField("Password", text: $password)
                        .font(.system(size: 16, weight: .bold)) // bold κείμενο
                        .textContentType(.password)
                }
                .frame(height: 44)
                .padding(.horizontal)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(color: Color("dblue").opacity(0.4), radius: 1, x: 0.5, y: 2)
                .padding(.horizontal)
                .padding(.bottom, isRegistering ? 25.5 : 10)
                
                HStack {
                    Spacer()
                    if !isRegistering {
                        Button("Forgot Password?") {
                            viewModel.resetPassword(email: email)
                        }
                        .font(.footnote)
                        .foregroundColor(.gray)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                Button(action: {
                    if isRegistering {
                        viewModel.register(email: email, password: password)
                    } else {
                        viewModel.signIn(email: email, password: password)
                    }
                }) {
                    Text(isRegistering ? "Register" : "Login")
                        .frame(maxWidth: .infinity)
                        .frame(height: 15)
                        .padding()
                        .background(dblue)
                        .foregroundColor(.white)
                        .bold()
                        .cornerRadius(10)
                }
                .disabled(viewModel.isLoading)
                .padding(.horizontal)
                .padding(.bottom, 20)
                
              Text("OR")
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .padding(.bottom, 20)
                
                
                SignInWithAppleButton(
                    onRequest: viewModel.handleAppleRequest,
                    onCompletion: viewModel.handleAppleCompletion
                )
                .frame(height: 48)
                .cornerRadius(10)
                .padding(.bottom, 60)
                .padding(.horizontal)
                
                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(error.contains("sent") ? .green : .red)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .font(.footnote)
                }
                
                Button(action: { isRegistering.toggle() }) {
                    Text(isRegistering ? "Already have an account? Login" : "No account? Register")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
