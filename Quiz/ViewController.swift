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
    let spinner = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDBFromEndpoint()
        
//        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
//            print(ConnectionManager.isConnected())
//            let human = Human(name: "John")
//            human.cat.append(Cat(name: "Meow"))
//            human.writeToRealm()
//            print(human)
//        }
    }
    
    @IBAction func retreiveData(_ sender: UIButton) {
        let objects = try! Realm().objects(Topic.self)
        
        for obj in objects {
            print(obj)
        }
        
    }
    
    func initializeDBFromEndpoint() {
        if !isInitialized {
            if ConnectionManager.isConnected() {
                downloadQuiz()
            } else {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                    if ConnectionManager.isConnected() {
                        self.downloadQuiz()
                        timer.invalidate()
                    }
                }
                showAlertWithTitle("Connection Error", message: "Wooops:(\nLooks like your network is down")
            }
        }
    }
    
    private func downloadQuiz() {
        addSpinner(spinner)
        DownloadManager.downloadQuiz { ids in
            ids.forEach { (id) in
                DownloadManager.downloadTopic(id: id) { (topic) in
                    guard let topic = topic else { return }
                    self.topics[id] = topic
                    self.counter += 1
                    print("\(self.counter) out of \(ids.count)")
                    if id == ids[ids.count-1] {
                        DispatchQueue.main.async {
                            self.removeSpinner(self.spinner)
                        }
                    }
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(topic)
                    }
                }
            }
            UserDefaults.standard.set(true, forKey: "isInitialized")
            UserDefaults.standard.synchronize()
        }
    }


}

