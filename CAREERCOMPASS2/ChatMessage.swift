//
//  ChatMessage.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 21/5/25.
//


import Foundation
import FirebaseFirestore

struct ChatMessage: Identifiable, Codable {
    @DocumentID var id: String?
    let senderId: String
    let text: String
    let timestamp: Date
    
    init(id: String? = nil, senderId: String, text: String, timestamp: Date = Date()) {
        self.id = id
        self.senderId = senderId
        self.text = text
        self.timestamp = timestamp
    }
}
