import SwiftUI
import FirebaseFirestore

struct WaitingForAgentView: View {
    let chatId: String
    let userId: String

    @State var bg_color = Color("background")
    @State var dblue = Color("dblue")
    @State var lblue = Color("lblue")

    @StateObject private var sessionObserver = ChatSessionObserver()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Group {
            if !sessionObserver.isActive {
                EmptyView()
            } else if let repId = sessionObserver.representativeId, !repId.isEmpty {
                ChatView(chatId: chatId, userId: userId, sessionObserver: sessionObserver)
            } else {
                ZStack {
                    bg_color.ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        Image("vector2")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    }
                    .ignoresSafeArea()
                    
                    VStack {
                        HStack {
                            Text("Αναμονή για σύνδεση...")
                                .font(.title2)
                                .foregroundStyle(dblue)
                                .bold()
                            Spacer()
                            
                            // Custom Exit Button πάνω δεξιά
                            Button(action: {
                                endChatAndExit()
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(dblue)
                            }
                        }
                        .padding()
                        
                        Spacer()
                        
                        ProgressView()
                            .padding(.bottom, 20)
                        
                        Text("Μην κλείσετε αυτό το παράθυρο")
                            .foregroundStyle(dblue)
                            .bold()
                        
                        Text("Καταβάλουμε προσπάθειες για να σας συνδέσουμε άμεσα με έναν σύμβουλο ψυχικής υγείας...")
                            .foregroundStyle(dblue)
                            .multilineTextAlignment(.center)
                            .lineLimit(4)
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    .onAppear {
                        sessionObserver.startListening(chatId: chatId)
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    // Συνάρτηση που τερματίζει το chat στο Firestore και κλείνει το view
    private func endChatAndExit() {
        let db = Firestore.firestore()
        let chatRef = db.collection("chats").document(chatId)
        
        chatRef.updateData([
            "isActive": false,
            "endedByUser": true,
            "endedAt": Timestamp(date: Date())
        ]) { error in
            if let error = error {
                print("Error ending chat: \(error.localizedDescription)")
            } else {
                print("Chat successfully ended")
            }
            // Κλείνουμε την οθόνη ανεξαρτήτως αν το update πετύχει ή όχι
            dismiss()
        }
    }
}
