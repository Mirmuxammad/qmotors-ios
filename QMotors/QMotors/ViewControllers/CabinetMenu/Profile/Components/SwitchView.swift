//
//  SwitchView.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 9.08.22.
//

import UIKit
import SnapKit

class SwitchView: UIView {

    // MARK: - UI Elements
    
    private let switchButton: UISwitch = {
        let button = UISwitch()
        button.onTintColor = UIColor.init(hex: "#9CC55A")
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontMed, size: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(switchButton)
        addSubview(titleLabel)

    }
    
    private func setupConstraints() {
        
        switchButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(switchButton.snp.right).offset(20)
            make.centerY.equalTo(switchButton)
            make.right.greaterThanOrEqualToSuperview()
        }
        
    }
    
    private func setTitleMobileDataColor() {
        guard let text = titleLabel.text else { return }
        let coloredString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "обработку \nмобильных данных")
        coloredString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hex: "#5A80C0"), range: range1)
        let range2 = (text as NSString).range(of: "обработку \nмобильных данных")
        coloredString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
        titleLabel.attributedText = coloredString
    }
    
    // MARK: - Public function
    
    func pushView() {
        titleLabel.text = "Согласен принимать Push \nуведомления на устройстве"
    }
    
    func smsView() {
        titleLabel.text = "Согласен принимать СМС"
    }
    
    func callView() {
        titleLabel.text = "Согласен принимать звонки"
    }
    
    func mobileDataView() {
        titleLabel.text = "Согласен на обработку \nмобильных данных"
        setTitleMobileDataColor()
    }
   
}
