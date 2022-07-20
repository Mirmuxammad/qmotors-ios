//
//  RegistrationVC.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 18.07.22.
//

import UIKit
import SnapKit
import SwiftMaskText

class RegistrationVC: BaseVC {
    
    //MARK: - Properties
    
    private var codeButtonTitle = "ПОЛУЧИТЬ КОД"
    private var requestCodeButtonTitle = "Отправить код повторно через"
    var timer: Timer?
    var timerLeftValue = 59
    var authResult: AuthResult?
    
    // MARK: - UI Elements
    
    private let registrationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Раздел доступен только \nдля зарегистрированных \nпользователей"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.init(hex: "#3E3E3E")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Введите номер телефона для \nполучения кода регистрации"
        return label
    }()
    
    private let phoneTextField: SwiftMaskField = {
        let textField = SwiftMaskField()
        textField.maskString = "+N (NNN) NNN-NN-NN"
        textField.placeholder = "+7 (___) __-__-__"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.init(hex: "#B6B6B6").cgColor
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let codeSmsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Введите код из СМС"
        label.isHidden = true
        return label
    }()
    
    private let codeTextField: SwiftMaskField = {
        let textField = SwiftMaskField()
        textField.placeholder = "----"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.init(hex: "#B6B6B6").cgColor
        textField.keyboardType = .numberPad
        textField.isHidden = true
        return textField
    }()
    
    private let requestCodeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(requestCodeButtonDidTap), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        button.setTitleColor(UIColor.black, for: .normal)
        button.isHidden = true
        return button
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "00:59"
        label.isHidden = true
        return label
    }()
    
    private let codeButton: ActionButton = {
        let button = ActionButton()
        button.setupButton(target: self, action: #selector(codeButtonDidTap))
        return button
    }()
    
    private let backButton: BackButton = {
        let button = BackButton()
        button.setupButton(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .large
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setRequestCodeButtonTitle(title: "Отправить код повторно через")
        
        hideKeyboardGesture()
        phoneTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        view.addSubview(registrationView)
        registrationView.addSubview(titleLabel)
        registrationView.addSubview(descriptionLabel)
        registrationView.addSubview(phoneTextField)
        registrationView.addSubview(codeSmsLabel)
        registrationView.addSubview(codeTextField)
        registrationView.addSubview(requestCodeButton)
        registrationView.addSubview(timerLabel)
        registrationView.addSubview(codeButton)
        registrationView.addSubview(activityIndicator)
        view.addSubview(backButton)
    }
    
    private func setupConstraints() {
        registrationView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(320)
            make.bottom.equalTo(backButton.snp.top).offset(-40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(55)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
        }
        
        codeSmsLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(55)
            make.top.equalTo(codeSmsLabel.snp.bottom).offset(20)
        }
        
        requestCodeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.lessThanOrEqualTo(timerLabel.snp.left).offset(10)
            make.top.equalTo(codeTextField.snp.bottom).offset(5)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(requestCodeButton)
        }
        
        codeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(55)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-100)
        }
        
    }
    
    private func hideKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height-100)
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func transformRegistrationView() {
        registrationView.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(470)
            make.bottom.equalToSuperview().offset(-100)
        }
        
        backButton.isHidden = true
        codeSmsLabel.isHidden = false
        codeTextField.isHidden = false
        requestCodeButton.isHidden = false
        timerLabel.isHidden = false
        
        codeButton.setupTitle(title: "РЕГИСТРАЦИЯ")
        codeButtonTitle = "РЕГИСТРАЦИЯ"
    }
    
    private func setRequestCodeButtonTitle(title: String) {
        requestCodeButton.setTitle(title, for: .normal)
        let attributes: [NSAttributedString.Key: Any] = [ .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(
            string: title,
            attributes: attributes
        )
        requestCodeButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    private func invalidSmsCode() {
        codeSmsLabel.text = "Код из СМС введен не верно"
        codeSmsLabel.textColor = .red
        codeSmsLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        
        codeTextField.textColor = .red
        codeTextField.layer.borderColor = UIColor.red.cgColor
        codeTextField.layer.borderWidth = 1
    }
    
    private func validSmsCode() {
        codeSmsLabel.text = "Введите код "
        codeSmsLabel.textColor = .black
        codeSmsLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        
        codeTextField.textColor = .black
        codeTextField.layer.borderColor = UIColor.clear.cgColor
        codeTextField.layer.borderWidth = 0
    }
    
    // MARK: - Network
    
    private func sendSmsCodeRequest() {
        activityIndicator.startAnimating()
        guard let phoneNumber = phoneTextField.text else { return }
        APIManager.shared.sendSmsCode(phoneNumber: phoneNumber) { [weak self] response in
            guard let self = self else { return }
            print(response)
            self.activityIndicator.stopAnimating()
            
        }
    }
    
    private func fetchUserData() {
        activityIndicator.startAnimating()
        guard
            let phoneNumber = phoneTextField.text,
            let smsCode = codeTextField.text else { return }
        APIManager.shared.fetchAuthResponse(phoneNumber: phoneNumber, smsCode: smsCode) { [weak self] response in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            
            if response.result != nil {
                print("correct code")
                self.validSmsCode()
            } else if let error = response.error {
                print(error.message)
                self.invalidSmsCode()
            }
            
        }
    }
    
    // MARK: - Private actions
    
    @objc private func codeButtonDidTap() {
        if codeButtonTitle == "РЕГИСТРАЦИЯ" {
            print("registerButtonDidTap")
            fetchUserData()
        } else {
            print("codeButtonDidTap")
            phoneTextField.endEditing(true)
            transformRegistrationView()
            sendSmsCodeRequest()
            phoneTextField.isEnabled = false
        }
    }
    
    @objc private func requestCodeButtonDidTap() {
        if timer == nil && requestCodeButtonTitle != "Отправить код еще раз" {
            print("requestCodeButtonDidTap")
            createTimer()
        } else if requestCodeButtonTitle == "Отправить код еще раз" {
            print("Отправить код еще раз")
            sendSmsCodeRequest()
            createTimer()
        } else {
            print("wait timer")
        }
    }
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
}

// MARK: - UITextFieldDelegate
extension RegistrationVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text!.count == 18 {
            codeButton.isEnabled()
        } else {
            codeButton.isDisabled()
        }
    }
}

// MARK: - Timer code update
extension RegistrationVC {
    @objc private func updateTimer() {
        setRequestCodeButtonTitle(title: "Отправить код повторно через")
        requestCodeButtonTitle = "Отправить код повторно через"
        self.timerLeftValue = self.timerLeftValue - 1
        self.timerLabel.text = convertTime(self.timerLeftValue)
        if self.timerLeftValue <= 0 {
            setRequestCodeButtonTitle(title: "Отправить код еще раз")
            requestCodeButtonTitle = "Отправить код еще раз"
            self.timerLabel.text = ""
            self.timer?.invalidate()
            self.timer = nil
            timerLeftValue = 59
        }
    }
    
    private func createTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    private func convertTime(_ input: Int) -> String {
        let time = TimeInterval(input)
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .abbreviated
        
        let formattedString = formatter.string(from: time)
        guard let outputTime = formattedString else {
            return ""
        }
        
        return outputTime
    }
}
