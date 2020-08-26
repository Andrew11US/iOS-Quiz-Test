//
//  DownloadManager.swift
//  Quiz
//
//  Created by Andrew on 8/24/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import Foundation

struct DownloadManager {
    static func downloadTest() {
        guard let url = URL(string: "http://quiz.o2.pl/api/v1/quizzes/0/100") else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print(json)
                    guard let dict = json as? [String: AnyObject] else { return }
                    if let count = dict["count"] as? Int {
                        print(":>> ", count)
                    }
                    var count = 0
                    if let items = dict["items"] as? [AnyObject] {
                        for item in items {
                            guard let itemDict = item as? [String: AnyObject] else { return }
                            print("#>>", itemDict["id"])
                            count += 1
                        }
                    }
                    print(count)
                }
                
                //                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                //                    // we have good data – go back to the main thread
                //                    DispatchQueue.main.async {
                //                        // update our UI
                //                        self.results = decodedResponse.results
                //                    }
                //                    return
                //                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
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
