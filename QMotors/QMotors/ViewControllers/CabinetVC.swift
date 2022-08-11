//
//  CabinetVC.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 21.07.22.
//

import UIKit
import SnapKit

class CabinetVC: BaseVC {
    
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
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Личный кабинет"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private let myCarsButton = PersonalAreaButton()
    
    private let historyButton = PersonalAreaButton()
    
    private let reminderButton = PersonalAreaButton()
    
    private let profileButton = PersonalAreaButton()
    
    private let bonusButton = PersonalAreaButton()
    
    private let signUpButton = PersonalAreaButton()
    
    private let logoutButton: LogoutButton = {
        let button = LogoutButton()
        button.setupButton(target: self, action: #selector(logoutButtonDidTap))
        return button
    }()
    
    private let backButton: CabinetBackButton = {
        let button = CabinetBackButton()
        button.setupButton(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        
        setupButtons()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(myCarsButton)
        verticalStackView.addArrangedSubview(historyButton)
        verticalStackView.addArrangedSubview(reminderButton)
        verticalStackView.addArrangedSubview(profileButton)
        verticalStackView.addArrangedSubview(bonusButton)
        verticalStackView.addArrangedSubview(signUpButton)
        backgroundView.addSubview(logoutButton)
        backgroundView.addSubview(backButton)
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
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(22)
        }
        
        
        verticalStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
            make.top.equalTo(titleLable.snp.bottom).offset(50)
            make.bottom.lessThanOrEqualTo(logoutButton.snp.top)
        }
 
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(backButton.snp.top).offset(-20)
        }
        
        backButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
    private func setupButtons() {
        
        guard
            let carImage = UIImage(named: "car"),
            let historyImage = UIImage(named: "history"),
            let reminderImage = UIImage(named: "ring"),
            let profileImage = UIImage(named: "profile"),
            let bonusImage = UIImage(named: "gift"),
            let signUpImage = UIImage(named: "pen")
        else { return }
        
        myCarsButton.setupButton(title: "МОИ АВТОМОБИЛИ", image: carImage, target: self, action: #selector(myCarsButtonDidTap))
        historyButton.setupButton(title: "ИСТОРИЯ", image: historyImage, target: self, action: #selector(historyButtonDidTap))
        reminderButton.setupButton(title: "СОЗДАТЬ НАПОМИНАНИЕ", image: reminderImage, target: self, action: #selector(reminderButtonDidTap))
        profileButton.setupButton(title: "ПРОФИЛЬ", image: profileImage, target: self, action: #selector(profileButtonnDidTap))
        bonusButton.setupButton(title: "БОНУСЫ", image: bonusImage, target: self, action: #selector(bonusButtonDidTap))
        signUpButton.setupButton(title: "ЗАПИСАТЬСЯ", image: signUpImage, target: self, action: #selector(signUpButtonDidTap))
    }
    
    private func showLogoutAlert() {
        let alert = UIAlertController(title: "Выход", message: "Вы точно хотите выйти из профиля?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            UserDefaultsService.sharedInstance.removeAuthToken()
            self?.router?.back()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Private actions
    
    @objc private func myCarsButtonDidTap() {
        print("myCarsButtonDidTap")
        router?.pushMyCarsVC()
    }
    
    @objc private func historyButtonDidTap() {
        print("historyButtonDidTap")
        router?.pushHistoryCarsVC()
    }
    
    @objc private func reminderButtonDidTap() {
        print("reminderButtonDidTap")
    }
    
    @objc private func profileButtonnDidTap() {
        print("profileButtonnDidTap")
        router?.pushProfileVC()
    }
    
    @objc private func bonusButtonDidTap() {
        print("bonusButtonDidTap")
    }
    
    @objc private func signUpButtonDidTap() {
        print("signUpButtonDidTap")
    }
    
    @objc private func logoutButtonDidTap() {
        print("logoutButtonDidTap")
        showLogoutAlert()
    }
    
    @objc private func backButtonDidTap() {
        router?.back()
    }

}
