//
//  ActionButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 18.07.22.
//

import UIKit
import SnapKit

class ActionButton: UIView {

    // MARK: - UI Elements
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "ПОЛУЧИТЬ КОД"
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        layer.backgroundColor = UIColor.init(hex: "#D4D4D4").cgColor
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(button)
    }
    
    private func setupConstraints() {
            
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Public function
    
    func setupButton(target: Any, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func isEnabled() {
        layer.backgroundColor = UIColor.init(hex: "#9CC55A").cgColor
        button.isEnabled = true
    }
    
    func isDisabled() {
        layer.backgroundColor = UIColor.init(hex: "#D4D4D4").cgColor
        button.isEnabled = false
    }
    
    func setupTitle(title: String) {
        titleLabel.text = title
    }
    
}
