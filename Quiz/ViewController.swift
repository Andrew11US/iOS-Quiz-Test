//
//  ViewController.swift
//  Quiz
//
//  Created by Andrew on 8/22/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DownloadManager.downloadTest()
        
        DownloadManager.downloadTopic(id: 6546212793951873) { (topic) in
            print(topic?.questionsCount)
        }
    }


}

