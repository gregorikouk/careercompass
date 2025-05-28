//
//  Articles.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 7/4/25.
//

import Foundation
import FirebaseFirestore


struct Article: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var image: String
    var title: String
    var content: String
    var detailed: String
    var date: String
    var author: String
    var category: String  // Νέο πεδίο
    
    enum CodingKeys: String, CodingKey {
        case id
        case image = "imageUrl" // 🔁 Το Firestore έχει "imageUrl"
        case title
        case content
        case detailed
        case date
        case author
        case category
    }
}
