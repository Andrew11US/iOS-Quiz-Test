//
//  ResultVC.swift
//  Quiz
//
//  Created by Andrew on 8/27/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {

    var topic: Topic?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let topic = topic else { return }
        print("Result: \(topic.latestResult)")
    }
    
    @IBAction func tryAgainTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func backToQuizzesTapped(_ sender: UIButton) {
//        dismiss(animated: true, completion: nil)
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
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
