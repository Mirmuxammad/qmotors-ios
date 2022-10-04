//
//  DeleteAccountButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 4.10.22.
//

import UIKit
import SnapKit

class DeleteAccountButton: UIView {

    // MARK: - UI Elements
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .red
        label.textAlignment = .center
        label.text = "Удалить аккаунт".uppercased()
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        layer.backgroundColor = UIColor.clear.cgColor
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1.5
        
        setupViews()
        setupConstraints()
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(button)
        addSubview(titleLabel)
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
