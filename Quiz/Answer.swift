//
//  Answer.swift
//  Quiz
//
//  Created by Andrew on 8/24/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

struct Answer: Codable {
    var order: Int
    var text: String
    var imageUrl: String?
    var isCorrect: Int
    
    init(order: Int, text: String, isCorrect: Int, imageUrl: String?) {
        self.order = order
        self.text = text
        self.imageUrl = imageUrl
        self.isCorrect = isCorrect
    }
    
    // Initialization from JSON
    init(data: [String: AnyObject]) {
        self.order = data["order"] as? Int ?? 0
        self.text = data["text"] as? String ?? "no data"
        self.imageUrl = data["url"] as? String ?? ""
        self.isCorrect = data["isCorrect"] as? Int ?? 0
    }
}
