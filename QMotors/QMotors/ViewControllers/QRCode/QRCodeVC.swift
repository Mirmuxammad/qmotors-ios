//
//  QRCodeVC.swift
//  QMotors
//
//  Created by Mavlon on 05/09/22.
//

import UIKit

class QRCodeVC: BaseVC {
    
    // MARK: - Properties
    
    var bonuses = [Bonus]()
    var balance = 0

    // MARK: - UI Elements
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "small_logo")
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let backButton: SmallBackButton = {
        let button = SmallBackButton()
        button.setupAction(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "QR - код"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let readyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Const.fontSemi, size: 14)
        button.backgroundColor = UIColor(hex: "9CC55A")
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.layer.borderWidth = 1
        view.layer.borderColor = Const.fieldBorderColor.cgColor
        return view
    }()
    
    private let qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "qrCode")
        return imageView
    }()
    
    private let qrLabel: UILabel = {
        let label = UILabel()
        label.text = "Покажите экран телефона нашему сотруднику"
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont(name: Const.fontSemi, size: 14)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    override func leftMenuButtonDidTap() {
        sideMenuVC.rootScreen = .techCenter
        super.leftMenuButtonDidTap()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(containerView)
        containerView.addSubview(qrImageView)
        containerView.addSubview(qrLabel)
        backgroundView.addSubview(readyButton)
    }
    
    private func setupConstraints() {
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 55, height: 55))
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 23))
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.height.equalTo(24)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        qrImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(qrImageView.snp.width)
        }
        
        qrLabel.snp.makeConstraints { make in
            make.top.equalTo(qrImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        readyButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(55)
            make.bottom.equalToSuperview().offset(-30)
        }
        
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    


}
