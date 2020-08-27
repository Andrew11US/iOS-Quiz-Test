//
//  Question.swift
//  Quiz
//
//  Created by Andrew on 8/24/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import RealmSwift

class Question: Object {
    @objc dynamic var order: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var imageUrl: String? = nil
    var answers = List<Answer>()
    
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
    
    required init() {}
}
