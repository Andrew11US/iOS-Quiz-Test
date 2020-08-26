//
//  ViewController.swift
//  Quiz
//
//  Created by Andrew on 8/22/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var topics: [Int: Topic] = [:]
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DownloadManager.downloadQuiz { ids in
            ids.forEach { (id) in
                DownloadManager.downloadTopic(id: id) { (topic) in
                    guard let topic = topic else { return }
                    self.topics[id] = topic
                    self.counter += 1
                    print("\(self.counter) out of 100")
                }
            }
        }
    }


}

