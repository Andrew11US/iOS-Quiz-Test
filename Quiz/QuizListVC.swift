//
//  ViewController.swift
//  Quiz
//
//  Created by Andrew on 8/22/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit
import RealmSwift

class QuizListVC: UIViewController {
    @IBOutlet weak var quizzesTableView: UITableView!
    
    private let spinner = SpinnerViewController()
    private var topics: [Topic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizzesTableView.delegate = self
        quizzesTableView.dataSource = self
        
        initializeDBFromEndpoint()
        retrieveDataFromDB()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleQuizChanges), name: .didUpdateQuiz, object: nil)
    }
    
    private func retrieveDataFromDB() {
        if topics.count == 0 {
            let topics = try! Realm().objects(Topic.self)
            
            for topic in topics {
                self.topics.append(topic)
            }
            quizzesTableView.reloadData()
        }
    }
    
    @objc private func handleQuizChanges() {
        topics = []
        let topics = try! Realm().objects(Topic.self)
        
        for topic in topics {
            self.topics.append(topic)
        }
        quizzesTableView.reloadData()
        
    }
    
    private func initializeDBFromEndpoint() {
        if !isInitialized {
            if ConnectionManager.isConnected() {
                downloadQuiz()
            } else {
                showAlertWithTitle("Connection Error", message: "Wooops:(\nLooks like your network is down")
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                    if ConnectionManager.isConnected() {
                        self.downloadQuiz()
                        timer.invalidate()
                    }
                }
            }
        }
    }
    
    private func downloadQuiz() {
        addSpinner(spinner)
        DownloadManager.downloadQuiz { ids in
            ids.forEach { (id) in
                DownloadManager.downloadTopic(id: id) { topic in
                    guard let topic = topic else { return }
                    self.topics.append(topic)
                    DispatchQueue.main.async {
                        let realm = try! Realm()
                        try! realm.write {
                            realm.add(topic)
                        }
                        if id == ids[ids.endIndex - 1] {
                            self.removeSpinner(self.spinner)
                            self.quizzesTableView.reloadData()
                        }
                    }
                }
            }
            UserDefaults.standard.set(true, forKey: "isInitialized")
            UserDefaults.standard.synchronize()
        }
    }
    
    // Prepare for segue to send selected topic
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuizVC {
            if let topic = sender as? Topic {
                destination.topic = topic
            }
        }
    }
}

// MARK: - UITableView delegate and dataSource
extension QuizListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topic = topics[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toQuiz", sender: topic)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as? QuizCell {
            let topic = topics[indexPath.row]
            cell.configureCell(topic: topic)
            return cell
        } else {
            return QuizCell()
        }
    }
}

