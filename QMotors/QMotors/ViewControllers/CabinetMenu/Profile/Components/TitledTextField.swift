//
//  TitledTextField.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 9.08.22.
//

import UIKit
import SnapKit
import SwiftMaskText

class TitledTextField: UIView {

    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontMed, size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let textField: SwiftMaskField = {
        let textField = SwiftMaskField()
//        textField.maskString = "+N (NNN) NNN-NN-NN"
//        textField.placeholder = "+7 (___) __-__-__"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.init(hex: "#B6B6B6").cgColor
//        textField.keyboardType = .numberPad
        
        return textField
    }()
        
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(textField)
    }
    
    private func setupConstraints() {

        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.height.equalTo(55)
        }
 
    }
    
    // MARK: - Public function
    
//    func setupAction(target: Any, action: Selector) {
//        button.addTarget(target, action: action, for: .touchUpInside)
//    }
    
    func fullNameView(delegate: UITextFieldDelegate) {
        textField.delegate = delegate
        titleLabel.text = "ФИО"
        textField.placeholder = "Ваше ФИО полностью"
    }

}

