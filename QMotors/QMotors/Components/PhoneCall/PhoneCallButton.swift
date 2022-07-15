//
//  PhoneCallButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 15.07.22.
//

import UIKit
import SnapKit

class PhoneCallButton: UIView {
    
    // MARK: - UI Elements
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "phone_call_detail_button")
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
    
    private func setupViews()  {
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(button)
    }
    
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.left.equalToSuperview().offset(20)
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
    
    func setupButton(title: String, target: Any, action: Selector) {
        titleLabel.text = title
        button.addTarget(target, action: action, for: .touchUpInside)
    }

}
