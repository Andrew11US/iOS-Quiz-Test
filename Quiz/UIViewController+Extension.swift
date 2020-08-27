//
//  UIViewController+Extension.swift
//  Quiz
//
//  Created by Andrew on 8/27/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertWithTitle(_ title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertVC.addAction(action)
        
        DispatchQueue.main.async { () -> Void in
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func addSpinner(_ spinner: SpinnerViewController) {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }

    func removeSpinner(_ spinner: SpinnerViewController) {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    
    func createNotification(name: Notification.Name) {
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
}
