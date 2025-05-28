//
//  ChatViewModel.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 21/5/25.
//
import Foundation
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    @Published var newMessageText: String = ""
    let chatId: String
    let userId: String
    private let db = Firestore.firestore()
    
    init(chatId: String, userId: String) {
        self.chatId = chatId
        self.userId = userId
    }
    
    func sendMessage() {
        guard !newMessageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let message = ChatMessage(senderId: userId, text: newMessageText)
        do {
            _ = try db.collection("chats").document(chatId).collection("messages").addDocument(from: message)
            newMessageText = ""
        } catch {
            print("Failed to send message: \(error.localizedDescription)")
        }
    }
}
