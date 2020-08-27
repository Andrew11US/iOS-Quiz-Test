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
        
        if sender.answer?.isCorrect == 1 {
            correct += 1
        } else {
            incorrect += 1
        }
        answerButtons.forEach { (button) in
            button.isHidden = true
        }
//        topic.progress += 1
        generateQuestion(topic: topic)
        print("Current: \(currectQuestion), C: \(correct) I: \(incorrect)")
    }
    
    private func performQuiz(topic: Topic) {
        var currectQuestion = topic.progress
        var correct = topic.correct
        var incorrect = topic.incorrect
        
    }
    
    func generateQuestion(topic: Topic) {
        let question = topic.questions[topic.progress]
        questionText.text = question.text
        for (index, answer) in question.answers.enumerated() {
            answerButtons[index].configure(answer: answer)
            answerButtons[index].isHidden = false
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
