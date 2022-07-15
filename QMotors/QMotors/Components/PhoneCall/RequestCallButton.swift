//
//  RequestCallButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 15.07.22.
//

import UIKit
import SnapKit

class RequestCallButton: UIView {
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "ЗАКАЗАТЬ ЗВОНОК"
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        titleUnderline()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setupViews()  {
        addSubview(titleLabel)
        addSubview(button)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func titleUnderline() {
        guard let text = titleLabel.text else { return }
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "ЗАКАЗАТЬ ЗВОНОК")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        titleLabel.attributedText = underlineAttriString
    }
    
    // MARK: - Public function
    
    func setupButton(target: Any, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
}
