//
//  QuizVC.swift
//  Quiz
//
//  Created by Andrew on 8/27/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit
import RealmSwift

class QuizVC: UIViewController {
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var answer1: AnswerButton!
    @IBOutlet weak var answer2: AnswerButton!
    @IBOutlet weak var answer3: AnswerButton!
    @IBOutlet weak var answer4: AnswerButton!
    
    var topic: Topic?
    var answerButtons: [AnswerButton] = []
    private var currectQuestion = 0
    private var correct = 0
    private var incorrect = 0
//    var questions = List<Question>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerButtons = [answer1, answer2, answer3, answer4]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let topic = topic else { return }
        navigationItem.title = topic.title
//        currectQuestion = topic.progress
//        correct = topic.correct
//        incorrect = topic.incorrect
        generateQuestion(topic: topic)
    }
    
    @IBAction func checkAnswerTapped(_ sender: AnswerButton) {
        guard let topic = topic else { return }
        let realm = try! Realm()
        answerButtons.forEach { $0.isHidden = true }
        
        try! realm.write {
            if sender.answer?.isCorrect == 1 {
                topic.correct += 1
            } else {
                topic.incorrect += 1
            }
            topic.progress += 1
            realm.add(topic, update: .modified)
        }
        
        if topic.progress < topic.questionsCount {
            generateQuestion(topic: topic)
        } else {
            try! realm.write {
                topic.latestResult = Int((Double(topic.correct) / Double(topic.questionsCount))*100)
                topic.progress = 0
                topic.correct = 0
                topic.incorrect = 0
                realm.add(topic, update: .modified)
            }
            performSegue(withIdentifier: "toResult", sender: topic)
        }
        
        print("Current: \(topic.progress), C: \(topic.correct) I: \(topic.incorrect)")
    }
    
    func generateQuestion(topic: Topic) {
        let question = topic.questions[topic.progress]
        questionText.text = question.text
        for (index, answer) in question.answers.enumerated() {
            answerButtons[index].configure(answer: answer)
            answerButtons[index].isHidden = false
        }
    }
    
    // Preparation to send results to ResultsVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ResultVC {
            if let topic = sender as? Topic {
                destination.topic = topic
            }
        }
    }
}
