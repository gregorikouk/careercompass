//
//  Videos.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 6/5/25.
//

import Foundation

struct Video: Hashable {
    var image: String
    var title: String
    var content: String
    var source: String
}

var videos: [Video] = [
    Video(image: "video1", title: "Γιατί η Τέχνη είναι απαραίτητη στον άνθρωπο;", content: "Μέσα από την Τέχνη ο άνθρωπος γίνεται καλύτερος, τόσο διανοητικά όσο και συναισθηματικά. Through Art we become better persons both intellectually and emotionaly.", source: "www.artspects.com")
]
