//
//  ViewController.swift
//  Quiz
//
//  Created by Andrew on 8/22/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    var topics: [Int: Topic] = [:]
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DownloadManager.downloadQuiz { ids in
//            ids.forEach { (id) in
//                DownloadManager.downloadTopic(id: id) { (topic) in
//                    guard let topic = topic else { return }
//                    self.topics[id] = topic
//                    self.counter += 1
//                    print("\(self.counter) out of 100")
//                }
//            }
//        }
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            print(ConnectionManager.isConnected())
            let obj = TestObject()
            obj.name = "TTT"
            obj.writeToRealm()
        }
    }
    
    @IBAction func retreiveData(_ sender: UIButton) {
        let objects = try! Realm().objects(TestObject.self)
        
        for obj in objects {
            print(obj.name)
        }
        
    }


}

