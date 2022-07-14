//
//  SideMenuButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 14.07.22.
//

import UIKit
import SnapKit

class SideMenuButton: UIView {

    // MARK: - UI Elements
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
            
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        addSubview(button)
    }
    
    private func setupConstraints() {
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
                
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Public function
    
    func setupButton(title: String, target: Any, action: Selector) {
        titleLabel.text = title
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
}
