//
//  UIViewController+Extension.swift
//  QMotors
//
//  Created by Akhrorkhuja on 26/07/22.
//

import UIKit
import MBProgressHUD

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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.bezelView.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        }
    }
    
    func dismissLoadingIndicator() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showAlert(with message: String, buttonTitle: String) {
        let alertVC = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .default) { _ in
            //
        }
        alertVC.addAction(ok)
        present(alertVC, animated: true)
    }
}
