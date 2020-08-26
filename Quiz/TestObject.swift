//
//  TestObject.swift
//  Quiz
//
//  Created by Andrew on 8/26/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import RealmSwift

class TestObject: Object {
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

extension TestObject {
    
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
