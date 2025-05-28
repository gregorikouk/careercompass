//
//  ChatView.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 21/5/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatView: View {
    let chatId: String
    let userId: String
    @ObservedObject var sessionObserver: ChatSessionObserver
    
    @StateObject private var messageObserver = ChatMessageObserver()
    @StateObject private var viewModel: ChatViewModel
    
    @Environment(\.presentationMode) var presentationMode

    init(chatId: String, userId: String, sessionObserver: ChatSessionObserver) {
        self.chatId = chatId
        self.userId = userId
        self._viewModel = StateObject(wrappedValue: ChatViewModel(chatId: chatId, userId: userId))
        self.sessionObserver = sessionObserver
    }
    
    @State var bg_color = Color("background")
    @State var dblue = Color("dblue")
    @State var lblue = Color("lblue")
    @State var cblue = Color("cblue")
    
    var body: some View {
        ZStack {
            ZStack {
                bg_color.ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("vector2")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }.ignoresSafeArea()
            }
            VStack {
                HStack {
                    Text("Συνομιλία")
                        .font(.title)
                        .bold()
                        .foregroundStyle(dblue)
                    Spacer()
                    
                    Button(role: .destructive) {
                        endChat()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(dblue)
                    }
                    
                }
                .padding()
       
                ScrollView {
                    ForEach(messageObserver.messages) { message in
                        HStack {
                            if message.senderId == userId {
                                Spacer()
                                Text(message.text)
                                    .padding(10)
                                    .background(cblue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .font(.subheadline)
                                    .frame(maxWidth: UIScreen.main.bounds.width * 2/3, alignment: .trailing)
                            } else {
                                Text(message.text)
                                    .padding(10)
                                    .foregroundColor(.white)
                                    .background(dblue)
                                    .cornerRadius(10)
                                    .font(.subheadline)
                                    .frame(maxWidth: UIScreen.main.bounds.width * 2/3, alignment: .leading)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    }
                }
                
                TextField("Aa..", text: $viewModel.newMessageText)
                    .font(.system(size: 16, weight: .bold))
                    .frame(height: 44)
                    .padding(.horizontal, 20) // άφησε χώρο για το κουμπί δεξιά
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(color: Color("dblue").opacity(0.4), radius: 1, x: 0.5, y: 2)
                    .overlay(
                        HStack {
                            Spacer()
                            Button {
                                viewModel.sendMessage()
                            } label: {
                                Rectangle()
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(10)
                                    .foregroundStyle(dblue)
                                    .overlay {
                                        Image("paperplane")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .offset(x: -1)
                                    }
                            }
                            .disabled(viewModel.newMessageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                            .padding(.trailing, 8)
                        }
                    )
                .padding()
                
                
            }
           
            .onAppear {
                messageObserver.startListening(chatId: chatId)
            }
            .onDisappear {
                messageObserver.stopListening()
            }
        }
    }
    
    private func endChat() {
        let db = Firestore.firestore()
        let sessionRef = db.collection("chats").document(chatId)
        sessionRef.updateData(["isActive": false]) { error in
            if let error = error {
                print("Error ending chat:", error.localizedDescription)
            } else {
                print("Chat ended by client")
                DispatchQueue.main.async {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    ChatView(
        chatId: "mock_chat_id_123",
        userId: "mock_user_id_456",
        sessionObserver: ChatSessionObserver()
    )
}
