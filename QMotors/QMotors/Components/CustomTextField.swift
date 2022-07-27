//
//  CustomTextField.swift
//  QMotors
//
//  Created by Akhrorkhuja on 26/07/22.
//

import UIKit

class CustomTextField: UITextField {
    
//    var isActive = false
    
    // MARK: - Initialization
    init(placeholder: String, keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        configure(placeholder: placeholder, keyboardType: keyboardType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func configure(placeholder: String, keyboardType: UIKeyboardType) {
        self.font = UIFont(name: Const.fontReg, size: 16)
        self.placeholder = placeholder
        self.textColor = Const.fieldTextColor
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = Const.fieldBorderColor.cgColor
        self.addPadding(padding: .equalSpacing(16))
        self.borderStyle = .roundedRect
        self.returnKeyType = .next
        self.keyboardType = keyboardType
    }

}
