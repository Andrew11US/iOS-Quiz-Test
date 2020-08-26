//
//  Question.swift
//  Quiz
//
//  Created by Andrew on 8/24/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

struct Question: Codable {
    var order: Int
    var text: String
    var imageUrl: String? = nil
    var answers: [Answer] = []
    
    init(order: Int, text: String, imageUrl: String?, answers: [Answer]) {
        self.order = order
        self.text = text
        self.imageUrl = imageUrl
        self.answers = answers
    }
    
    // Initialization from JSON
    init(data: [String: AnyObject]) {
        self.order = data["order"] as? Int ?? 0
        self.text = data["text"] as? String ?? "no data"
        self.imageUrl = data["url"] as? String
        if let answers = data["answers"] as? [AnyObject] {
            for answer in answers {
                guard let answerDict = answer as? [String: AnyObject] else { return }
                let answerFromJson = Answer(data: answerDict)
                self.answers.append(answerFromJson)
            }
        }
    }
}
