//
//  Topic.swift
//  Quiz
//
//  Created by Andrew on 8/24/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

struct Topic: Codable {
    var id: Int
    var title: String
    var questionsCount: Int
    var category: String
    var imageUrl: String?
    var questions: [Question]
    //    var progress: Int
    //    var correct: Int
    //    var incorrect: Int
    
    init(id: Int, title: String, questionsCount: Int, category: String, imageUrl: String? = nil, questions: [Question]) {
        self.id = id
        self.title = title
        self.questionsCount = questionsCount
        self.category = category
        self.imageUrl = imageUrl
        self.questions = questions
    }
    
    
}

