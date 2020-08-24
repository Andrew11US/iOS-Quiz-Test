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
//        guard let url = URL(string: "http://quiz.o2.pl/api/v1/quiz/6546212793951873/0") else { return }
        guard let url = URL(string: "http://quiz.o2.pl/api/v1/quizzes/0/100") else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print(json)
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
}
