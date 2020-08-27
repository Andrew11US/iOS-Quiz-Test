//
//  ResultVC.swift
//  Quiz
//
//  Created by Andrew on 8/27/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    @IBOutlet weak var resultLbl: UILabel!
    var topic: Topic?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let topic = topic else { return }
        
        resultLbl.text = """
        \(showResult(topic: topic))
        
        Your score is
        \(topic.latestResult)%
        """
    }
    
    @IBAction func backToQuizzesTapped(_ sender: UIButton) {
//        dismiss(animated: true, completion: nil)
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func showResult(topic: Topic) -> String {
        switch topic.latestResult {
        case 0..<30:
            return "Just a try"
        case 30..<50:
            return "Something better than nothing"
        case 50..<70:
            return "Not bad"
        case 70..<80:
            return "Good one!"
        case 80..<90:
            return "Super!"
        case 90...100:
            return "Excellent!"
        default:
            return ""
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
