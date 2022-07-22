//
//  LogoutButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 21.07.22.
//

import UIKit
import SnapKit

class LogoutButton: UIView {
    
    // MARK: - UI Elements
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "ВЫХОД"
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
        
        layer.cornerRadius = 5
        layer.backgroundColor = UIColor.clear.cgColor
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.5
        
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
    

    
}
