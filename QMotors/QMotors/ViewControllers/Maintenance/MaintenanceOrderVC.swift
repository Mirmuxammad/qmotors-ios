//
//  MaintenanceOrderVC.swift
//  QMotors
//
//  Created by Temur Juraev on 07.08.2022.
//

import UIKit
import SnapKit

class MaintenanceOrderVC: BaseVC, UITextFieldDelegate {
    
    // MARK: - UI Elements
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "small_logo")
        return imageView
    }()
    
    private let dateTF: UITextField = {
       let textField = UITextField()
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        let localeID = Locale.preferredLanguages.first
        picker.locale = Locale(identifier: localeID!)
        return picker
    }()
    
    // MARK: - Views
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Buttons
    private let backButton: SmallBackButton = {
        let button = SmallBackButton()
        button.setupAction(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    private let sendOrderButton: ActionButton = {
        let button = ActionButton()
        button.setupButton(target: self, action: #selector(sendOrder))
        button.setupTitle(title: "ОТПРАВИТЬ ЗАЯВКУ")
        button.backgroundColor = UIColor(hex: "#9CC55A")
        button.frame.size = CGSize(width: 341, height: 55)
        button.isEnabled()
        return button
    }()
    
    // MARK: - Labels
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Заполните заявку на бесплатную диагностику"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let secondTitleLable: UILabel = {
        let label = UILabel()
        label.text = "Ваш автомобиль"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let thirdTitleLable: UILabel = {
        let label = UILabel()
        label.text = "Укажите дату и время"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let infoAboutCar: CustomTextField = {
        let field = CustomTextField(placeholder: "Из списка ваших автомобилей")
        return field
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
    }
    
    // MARK: - Private actions
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func sendOrder() {
        print(#function)
    }
    
    private func setupView() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(secondTitleLable)
        backgroundView.addSubview(thirdTitleLable)
        backgroundView.addSubview(infoAboutCar)
        backgroundView.addSubview(dateTF)
        backgroundView.addSubview(datePicker)
        backgroundView.addSubview(sendOrderButton)
        
        dateTF.inputView = datePicker
        infoAboutCar.inputView = UIView()
        infoAboutCar.delegate = self
        
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
            make.top.equalToSuperview().offset(40)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(backButton.snp.bottom).offset(20)
        }
        
        secondTitleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.height.equalTo(22)
        }
        
        infoAboutCar.snp.makeConstraints { make in
            make.top.equalTo(secondTitleLable.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        thirdTitleLable.snp.makeConstraints { make in
            make.top.equalTo(infoAboutCar.snp.bottom).offset(20)
            make.height.equalTo(22)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)

        }
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(thirdTitleLable.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        sendOrderButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(28)
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    
    
}


extension MaintenanceOrderVC {
    
}
