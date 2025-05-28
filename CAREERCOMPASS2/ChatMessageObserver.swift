//
//  ChatMessageObserver.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 21/5/25.
//


import Foundation
import FirebaseFirestore

class ChatMessageObserver: ObservableObject {
    @Published var messages: [ChatMessage] = []
    private var listener: ListenerRegistration?
    
    func startListening(chatId: String) {
        let db = Firestore.firestore()
        listener = db.collection("chats").document(chatId).collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error listening messages: \(error.localizedDescription)")
                    return
                }
                guard let docs = snapshot?.documents else {
                    print("No messages")
                    return
                }
                self?.messages = docs.compactMap { try? $0.data(as: ChatMessage.self) }
            }
    }
    
    func stopListening() {
        listener?.remove()
    }
    
    deinit {
        stopListening()
    }
}
