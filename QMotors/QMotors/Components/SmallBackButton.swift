//
//  SmallBackButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 23.07.22.
//

import UIKit
import SnapKit

class SmallBackButton: UIView {

    // MARK: - UI Elements
    
    private let titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "back_black_arrow")
        return imageView
    }()
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Назад"
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
            make.width.equalTo(80)
            make.center.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
            
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.centerY.equalTo(logoImageView)
        }
    
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Public function
    
    func setupAction(target: Any, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    

}

