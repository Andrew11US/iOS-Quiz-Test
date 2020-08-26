//
//  Answer.swift
//  Quiz
//
//  Created by Andrew on 8/24/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import RealmSwift

class Answer: Object {
    @objc dynamic var order: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var imageUrl: String? = nil
    @objc dynamic var isCorrect: Int = 0
    
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
        self.imageUrl = data["url"] as? String
        self.isCorrect = data["isCorrect"] as? Int ?? 0
    }
    
    required init() {}
    
//    override static func primaryKey() -> String? {
//        return "text"
//    }
}


