//
//  DeleteButton.swift
//  QMotors
//
//  Created by MIrmuxammad on 09/08/22.
//

import UIKit
import SnapKit

class  DeleteButton: UIView {

    // MARK: - UI Elements
        
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "trash")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isEnabled = true
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        layer.backgroundColor = UIColor.init(hex: "#EF4646").cgColor
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(button)
    }
    
    private func setupConstraints() {
            
        imageView.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.width.equalTo(23)
            make.center.equalToSuperview()
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
    
    func setupImage(image: UIImage) {
        imageView.image = image
    }
    
}

