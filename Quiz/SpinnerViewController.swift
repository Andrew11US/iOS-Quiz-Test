//
//  SpinnerViewController.swift
//  Quiz
//
//  Created by Andrew on 8/27/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .white)
    var label: UILabel!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        label = UILabel(frame: CGRect(x: 110, y: 200, width: 300, height: 50))
        label.layer.opacity = 0.7
        label.text = "Preparing for offline..."
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        view.addSubview(label)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
