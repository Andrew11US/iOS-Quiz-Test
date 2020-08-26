//
//  AnswerRealm.swift
//  Quiz
//
//  Created by Andrew on 8/26/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import RealmSwift

class AnswerObject: Object {
    var order: Int = 0
    var text: String = ""
    var imageUrl: String? = nil
    var isCorrect: Int = 0
    
    // Initialization from JSON
    init(data: [String: AnyObject]) {
        self.order = data["order"] as? Int ?? 0
        self.text = data["text"] as? String ?? "no data"
        self.imageUrl = data["url"] as? String
        self.isCorrect = data["isCorrect"] as? Int ?? 0
    }
    
    required init() {}
}

extension AnswerObject {
    
    func writeToRealm() {
        do {
            try realmFile.write {
//                realmFile.add(self, update: true)
                realmFile.add(self, update: .modified)
            }
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        
//        try! realmFile.write {
//            realmFile.add(self, update: true)
//        }
    }
}
