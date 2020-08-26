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
    var questionsCount: Int = 0
    var category: String = ""
    var imageUrl: String? = nil
    var questions: [Question] = []
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
    
    // Initialization from JSON
    init(data: [String: AnyObject]) {
        self.id = data["id"] as? Int ?? 0
        self.title = data["title"] as? String ?? "no data"
        
        if let category = data["category"] as? [String: AnyObject] {
            if let name = category["name"] as? String {
                self.category = name
            }
        }
        
        if let mainPhoto = data["mainPhoto"] as? [String: AnyObject] {
            if let url = mainPhoto["url"] as? String {
                self.imageUrl = url
            }
        }
        
        if let questions = data["questions"] as? [AnyObject] {
            for question in questions {
                guard let questionDict = question as? [String: AnyObject] else { return }
                let questionFromJson = Question(data: questionDict)
                self.questions.append(questionFromJson)
                questionsCount += 1
            }
        }
    }
}

