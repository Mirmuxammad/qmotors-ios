//
//  ProfileVC.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 9.08.22.
//

import UIKit
import SnapKit
import SwiftMaskText

class ProfileVC: BaseVC {
    
    // MARK: - Properties
    
    private var fileURLArray: [URL] = [] {
        didSet {
            print(fileURLArray)
        }
    }

    private var user: User? {
        didSet {
            
        }
    }
    private var isMale: Int = 1
    // MARK: - UI Elements
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "small_logo")
        return imageView
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
//    private let backgroundView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .red
//        return view
//    }()
//
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = true
        view.alwaysBounceVertical = true
        return view
    }()
    
    private let photoLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваше фото"
        label.font = UIFont(name: Const.fontMed, size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let photoView: CustomPhotoView = {
        let photoView = CustomPhotoView()
        photoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        photoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)
        return photoView
    }()
    
    private let fullNameView: TitledTextField = {
        let view = TitledTextField()
        return view
    }()
    
    private let genderTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш пол"
        label.font = UIFont(name: Const.fontMed, size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let maleGenderSwitch: GenderSwitch = {
        let view = GenderSwitch()
        view.genderText.text = "мужской"
        view.setupAction(target: self, action: #selector(genderButton))
        return view
    }()
    
    
    private let famaleGenderSwitch: GenderSwitch = {
        let view = GenderSwitch()
        view.genderText.text = "женский"
        view.setupAction(target: self, action: #selector(genderButton))
        return view
    }()
    
    private let birthdayView: BirthdayPicker = {
        let view = BirthdayPicker()
        return view
    }()
    
    private let emailView: TitledTextField = {
        let view = TitledTextField()
        return view
    }()
    
    private let phoneView: TitledTextField = {
        let view = TitledTextField()
        view.textField.isUserInteractionEnabled = false
        view.textField.textColor = .systemGray
        return view
    }()
    
    private let extraPhoneView: TitledTextField = {
        let view = TitledTextField()
        return view
    }()
    
    private let backButton: SmallBackButton = {
        let button = SmallBackButton()
        button.setupAction(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    private let servicesLable: UILabel = {
        let label = UILabel()
        label.text = "Управление услугами"
        label.font = UIFont(name: Const.fontMed, size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let pushView: SwitchView = {
        let view = SwitchView()
        return view
    }()
    
    private let smsView: SwitchView = {
        let view = SwitchView()
        return view
    }()
    
    private let callView: SwitchView = {
        let view = SwitchView()
        return view
    }()
    
    private let mobileDataView: SwitchView = {
        let view = SwitchView()
        return view
    }()
    
    
    private let saveProfileButton: ActionButton = {
        let button = ActionButton()
        button.setupButton(target: self, action: #selector(saveProfileButtonDidTap))
        button.setupTitle(title: "СОХРАНИТЬ")
        button.isEnabled()
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .large
        view.layer.zPosition = 1
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUSerInfo()
        
        setupViews()
        setupConstraints()
        
        genderSwitchLoad()
        
        fullNameView.fullNameView(delegate: self)
        emailView.emailView(delegate: self)
        phoneView.phoneNumberView(delegate: self)
        extraPhoneView.extraPhoneNumberView(delegate: self)
        
        pushView.pushView()
        smsView.smsView()
        callView.callView()
        mobileDataView.mobileDataView()
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + 2000)
//        scrollView.frame = self.view.bounds
        
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
     //   scrollView.addSubview(backgroundView)
        
        scrollView.addSubview(backButton)
        scrollView.addSubview(titleLable)
        scrollView.addSubview(photoLabel)
        scrollView.addSubview(photoView)
        scrollView.addSubview(fullNameView)
        
        scrollView.addSubview(genderTextLabel)
        scrollView.addSubview(maleGenderSwitch)
        scrollView.addSubview(famaleGenderSwitch)
        
        scrollView.addSubview(birthdayView)
        
        scrollView.addSubview(emailView)
        scrollView.addSubview(phoneView)
        scrollView.addSubview(extraPhoneView)
        scrollView.addSubview(servicesLable)
        scrollView.addSubview(pushView)
        scrollView.addSubview(smsView)
        scrollView.addSubview(callView)
        scrollView.addSubview(mobileDataView)
        
        
        view.addSubview(saveProfileButton)

    }

    private func setupConstraints() {
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 55, height: 55))
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
//        backgroundView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.width.equalTo(self.view.frame.size.width)
//        }
                
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 23))
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(40)
        }
                
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(backButton.snp.bottom).offset(15)
            make.height.equalTo(22)
        }
        
        photoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        photoView.snp.makeConstraints { make in
            make.top.equalTo(photoLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        fullNameView.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(90)
        }
        
        genderTextLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }

        maleGenderSwitch.snp.makeConstraints { make in
            make.top.equalTo(genderTextLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        
        famaleGenderSwitch.snp.makeConstraints { make in
            make.top.equalTo(genderTextLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(160)
            make.height.equalTo(30)
        }
        
        birthdayView.snp.makeConstraints { make in
            make.top.equalTo(famaleGenderSwitch.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(125)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(birthdayView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(90)
        }
        
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(90)
        }
        
        extraPhoneView.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(90)
        }
        
        servicesLable.snp.makeConstraints { make in
            make.top.equalTo(extraPhoneView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }
        
        pushView.snp.makeConstraints { make in
            make.top.equalTo(servicesLable.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        smsView.snp.makeConstraints { make in
            make.top.equalTo(pushView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        callView.snp.makeConstraints { make in
            make.top.equalTo(smsView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        mobileDataView.snp.makeConstraints { make in
            make.top.equalTo(callView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-100)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        saveProfileButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    
    private func reloadUserPhotos() {
        if fileURLArray.isEmpty {
            photoView.photo = UIImage(named: "empty-photo")!
            return
        }
        do {
            let photoData = try Data(contentsOf: fileURLArray[0])
            guard let image = UIImage(data: photoData) else { return }
            photoView.photo = image
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func loadUSerInfo() {
        self.activityIndicator.startAnimating()
        ProfileAPI.profile { user in
            print(user.result)
            self.user = user.result
            self.userInfoLoad(user: user.result)
            self.activityIndicator.stopAnimating()
        } failure: { error in
            print(error)
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    private func genderSwitchLoad(){
        if isMale == 1 {
            maleGenderSwitch.smallElipce.backgroundColor = UIColor.init(hex: "#9CC55A")
            famaleGenderSwitch.smallElipce.backgroundColor = .clear
        } else {
            maleGenderSwitch.smallElipce.backgroundColor = .clear
            famaleGenderSwitch.smallElipce.backgroundColor = UIColor.init(hex: "#9CC55A")
        }
    }
    
    private func userInfoLoad(user: User) {
        let name = user.name ?? ""
        let surname = user.surname ?? ""
        let patronymic = user.patronymic ?? ""
        fullNameView.textField.text = String("\(surname) \(name) \(patronymic)")
        if user.gender == 0 {
            maleGenderSwitch.smallElipce.backgroundColor = UIColor.init(hex: "#9CC55A")
            famaleGenderSwitch.smallElipce.backgroundColor = .clear
        } else {
            famaleGenderSwitch.smallElipce.backgroundColor = UIColor.init(hex: "#9CC55A")
            maleGenderSwitch.smallElipce.backgroundColor = .clear
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let userBrithday = formatter.date(from: user.birthday ?? "")
        birthdayView.datePicker.date = userBrithday  ?? Date()
        emailView.textField.text = user.email
        phoneView.textField.text = user.phoneNumber
        if user.phoneNumber == "" {
            titleLable.text = "Создать профиль"
        } else {
            titleLable.text = "Редактировать"
        }
        let sms = user.agreeSMS
        let calls = user.agreeCalls
        let agreeData = user.agreeData
        let pushNoti = user.agreeNotification
        pushView.switchButton.isOn = pushNoti
        callView.switchButton.isOn = calls
        mobileDataView.switchButton.isOn = agreeData
        smsView.switchButton.isOn = sms
        if let userAvatar = user.avatar{
            let photoUrl = BaseAPI.baseURL + userAvatar
            photoView.imageView.sd_setImage(with: URL(string: photoUrl), placeholderImage: nil)
        }
    }
    
    private func addUserAvatar(userId: Int, completion: @escaping () -> Void) {
        print(#function)
        guard let avatarURL = fileURLArray.first else { return }
        if fileURLArray.isEmpty {
            completion()
            return
        }
        ProfileAPI.addAvatar(userId: userId, fileURL: avatarURL, success: { [weak self] result in
            self?.fileURLArray = []
        }) { error in
            print(error)
            completion()
        }
    }
    

    // MARK: - Private actions
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func genderButton() {
        if isMale == 1 {
            isMale = 2
        } else if isMale == 2 {
            isMale = 1
        }
        if isMale == 1 {
            maleGenderSwitch.smallElipce.backgroundColor = UIColor.init(hex: "#9CC55A")
            famaleGenderSwitch.smallElipce.backgroundColor = .clear
        } else {
            maleGenderSwitch.smallElipce.backgroundColor = .clear
            famaleGenderSwitch.smallElipce.backgroundColor = UIColor.init(hex: "#9CC55A")
        }
    }
    
    @objc private func photoButtonTapped() {
        print(#function)
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @objc private func removePhotoButtonTapped(_ sender: UIButton) {
        print(#function)
        let photoView = sender.superview as! CustomPhotoView
        photoView.photo = UIImage(named: "empty-photo")!
        if photoView == self.photoView {
            fileURLArray.removeAll()
        }
        reloadUserPhotos()
    }
    
    @objc private func saveProfileButtonDidTap() {
        
        guard let split = fullNameView.textField.text?.split(separator: " ") else { return }
        
        var userName: String
        var surname: String
        var patronymic: String
        
        if split.count == 4{
            userName = String(split[1])
            surname = String(split[0])
            patronymic = String(split[2] + split[3])
        } else if split.count == 3 {
            userName = String(split[1])
            surname = String(split[0])
            patronymic = String(split[2])
        } else if split.count == 2 {
            userName = String(split[1])
            surname = String(split[0])
            patronymic = ""
        } else if split.count == 1 {
            userName = String(split[0])
            surname = ""
            patronymic = ""
        } else {
            userName = ""
            surname = ""
            patronymic = ""
        }
        guard let userId = user?.id else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let brithdayStr = formatter.string(from: birthdayView.datePicker.date)
        
        guard let phoneNumber = phoneView.textField.text, let email = emailView.textField.text else { return }
        
        ProfileAPI.postUser(surname: surname, name: userName, patronymic: patronymic, phoneNumber: phoneNumber, email: email, brithday: brithdayStr, gender: isMale, agreeNotification: pushView.switchButton.isOn , agreeSms: smsView.switchButton.isOn, agreeCalls: callView.switchButton.isOn, agreeData: mobileDataView.switchButton.isOn,  success: { [weak self] result in
            
            self?.addUserAvatar(userId: result["id"].intValue, completion: { [weak self] in
                self?.activityIndicator.stopAnimating()
                guard let strongSelf = self else { return }
                [strongSelf.photoView].forEach { $0.photo = UIImage(named: "empty-photo")! }
                self?.router?.back()
            })
            
            self?.router?.back()
        }) { [weak self] error in
            
            self?.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let data = image.jpegData(compressionQuality: 0.8)
        let documentUrl = getDocumentsDirectory()
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("jpg")
        try! data!.write(to: documentUrl)
        
        fileURLArray = [(documentUrl)]
        
        print(documentUrl)
        
        dismiss(animated: true) { [weak self] in
            if let data = data, let image = UIImage(data: data) {
                if self?.photoView.photo == UIImage(named: "empty-photo") {
                    self?.photoView.photo = image
                    UserDefaults.standard.set("\(documentUrl)", forKey: "profilePhotoUrl")
                }
            }
        }
    }
}

extension ProfileVC: UITextFieldDelegate {
    
}
