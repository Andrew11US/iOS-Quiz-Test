//
//  DownloadManager.swift
//  Quiz
//
//  Created by Andrew on 8/24/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import Foundation

struct DownloadManager {
    static func downloadQuiz(completion: @escaping ([Int]) -> Void) {
        guard let url = URL(string: "http://quiz.o2.pl/api/v1/quizzes/0/100") else { return }
        let request = URLRequest(url: url)
        var quizIDs: [Int] = []
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    guard let dict = json as? [String: AnyObject] else { return }
                    
                    if let items = dict["items"] as? [AnyObject] {
                        for item in items {
                            guard let itemDict = item as? [String: AnyObject] else { return }
                            guard let id = itemDict["id"] as? Int else { return }
                            quizIDs.append(id)
                        }
                        completion(quizIDs)
                    }
                }
            }
        }.resume()
    }
    
    static func downloadTopic(id: Int, completion: @escaping (Topic?) -> Void) {
        guard let url = URL(string: "http://quiz.o2.pl/api/v1/quiz/\(id)/0") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    if let dict = json as? [String: AnyObject] {
                        let topic = Topic(data: dict)
                        completion(topic)
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
