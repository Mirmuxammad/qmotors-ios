//
//  UIViewController+Extension.swift
//  QMotors
//
//  Created by Akhrorkhuja on 26/07/22.
//

import UIKit

extension UIViewController {
    func setupHideKeyboardOnTapView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
