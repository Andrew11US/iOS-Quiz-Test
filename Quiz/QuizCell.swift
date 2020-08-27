//
//  QuizCell.swift
//  Quiz
//
//  Created by Andrew on 8/27/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit

class QuizCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(topic: Topic) {
        titleLbl.text = topic.title
        if topic.latestResult > 0 {
            statusLbl.text = "Latest result: \(topic.latestResult)%"
        } else if topic.progress > 0 {
            let progress = Int((Double(topic.progress) / Double(topic.questionsCount))*100)
            statusLbl.text = "Progress: \(progress)%"
        } else {
            statusLbl.text = ""
        }
    }

}
