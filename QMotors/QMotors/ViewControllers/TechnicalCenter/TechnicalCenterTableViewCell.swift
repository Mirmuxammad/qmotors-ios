//
//  TechnicalCenterTableViewCell.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 28.07.22.
//

import UIKit
import SnapKit

class TechnicalCenterTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "TechnicalCenterTableViewCell"
    
    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#F8F8F8")
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "technical_center")
        return imageView
    }()
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontBold, size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "ЭНТУЗИАСТОВ"
        return label
    }()
    
    private let phoneNumberButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.init(hex: "#5A80C0"), for: .normal)
        button.titleLabel?.font = UIFont(name: Const.fontSemi, size: 14)
        button.setTitle("+7 (495) 638 52 25", for: .normal)
        return button
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "2 - я кабельная ул., д.2, стр. 30 ( заезд с 1-го кабельного проезда)"
        return label
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let navigationButton = TechCellNaviButton()
    
    private let signUpButton = TechCellSingUpButton()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(phoneNumberButton)
        containerView.addSubview(addressLabel)
        containerView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(navigationButton)
        horizontalStack.addArrangedSubview(signUpButton)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(14)
        }
        
        phoneNumberButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(14)
            make.centerY.equalTo(titleLabel)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 48, height: 48))
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
                
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(30)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(logoImageView)
            
        }
        
        horizontalStack.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.left)
            make.right.equalTo(addressLabel.snp.right)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
    // MARK: - Private actions
    
    @objc private func navigationButtonDidTap() {
        print("navigationButtonDidTap")
    }
    
    @objc private func signUpButtonDidTap() {
        print("signUpButtonDidTap")
    }
        
    // MARK: - Public functions
    
    func setupCell(_ with: TechnicalCenter) {
        titleLabel.text = with.title
        addressLabel.text = with.address
        phoneNumberButton.setTitle(with.phone, for: .normal)
    }
    
    func setupPhoneAction(target: Any, action: Selector) {
        phoneNumberButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setupNavigationAction(target: Any, action: Selector) {
        navigationButton.setupAction(target: target, action: action)
    }
    
    func setupSignUpAction(target: Any, action: Selector) {
        signUpButton.setupAction(target: target, action: action)
    }
    
}
