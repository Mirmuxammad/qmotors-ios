//
//  PersonalAreaButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 21.07.22.
//

import UIKit
import SnapKit

class PersonalAreaButton: UIView {

    // MARK: - UI Elements
    
    private let titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        return imageView
    }()
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 18)
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
        addSubview(titleView)
        titleView.addSubview(logoImageView)
        titleView.addSubview(titleLabel)
        addSubview(button)
    }
    
    private func setupConstraints() {
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(100)
//            make.center.equalToSuperview()
            make.left.equalToSuperview()
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
            make.edges.equalToSuperview().offset(0)
        }
    }
    
    // MARK: - Public function
    
    func setupButton(title: String, image: UIImage, target: Any, action: Selector) {
        titleLabel.text = title
        logoImageView.image = image
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    

}
