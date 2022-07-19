//
//  BackButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 19.07.22.
//

import UIKit
import SnapKit

class BackButton: UIView {
    
    // MARK: - UI Elements
    
    private let titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.left")
//        imageView.image = UIImage(named: "back_arrow")
        imageView.tintColor = .white
        return imageView
    }()
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "НАЗАД"
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
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.5
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(titleView)
        titleView.addSubview(logoImageView)
        titleView.addSubview(titleLabel)
        addSubview(button)
    }
    
    private func setupConstraints() {
        
        titleView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.center.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
            
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(15)
            make.centerY.equalTo(logoImageView)
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
