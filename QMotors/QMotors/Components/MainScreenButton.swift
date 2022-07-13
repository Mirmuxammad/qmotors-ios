//
//  MainScreenButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 13.07.22.
//

import UIKit
import SnapKit

class MainScreenButton: UIView {

    // MARK: - UI Elements
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .white
        label.textAlignment = .center
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
        
        layer.cornerRadius = 10
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(backgroundImageView)
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(button)
    }
    
    private func setupConstraints() {
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerY.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Public function
    
    func setupButton(title: String, target: Any, action: Selector, logoImage: UIImage, backgroundImage: UIImage?) {
        titleLabel.text = title
        button.addTarget(target, action: action, for: .touchUpInside)
        logoImageView.image = logoImage
        backgroundImageView.image = backgroundImage
    }
    
}
