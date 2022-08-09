//
//  TechnicalRecordVC.swift
//  QMotors
//
//  Created by Temur Juraev on 07.08.2022.
//

import UIKit
import SnapKit

class TechnicalRecordVC: BaseVC {
    
    let testArray = ["Техническое обслуживания", "Слесарный ремонт", "Кузовной ремонт", "Детайлинг", "Другое"]
    
    private let cellIdentifier = "optionsTableCell"
    private var userAutosData = [UserAutos]()
    
    private var fileURLArray: [URL] = [] {
        didSet {
            print(fileURLArray)
        }
    }
    
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
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        let localeID = Locale.preferredLanguages.first
        picker.locale = Locale(identifier: localeID!)
        return picker
    }()
    
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    
    //MARK: - Buttons
    private let backButton: SmallBackButton = {
        let button = SmallBackButton()
        button.setupAction(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    private let carModelChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
        return button
    }()
    
    private let optionsChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
        return button
    }()
    
    private let sendOrderButton: ActionButton = {
        let button = ActionButton()
        button.setupTitle(title: "ОТПРАВИТЬ ЗАЯВКУ")
        button.setupButton(target: self, action: #selector(addSendButtonTapped))
        button.isEnabled()
        return button
    }()
    
    
    //MARK: - Labels
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Записаться"
        label.font = UIFont(name: Const.fontSemi, size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let userCarLabel: CustomLabel = {
        let label = CustomLabel(text: "Ваш автомобиль", fontWeight: .medium)
        return label
    }()
    
    private let timeMarkLabel: CustomLabel = {
        let label = CustomLabel(text: "Укажите дату и время", fontWeight: .medium)
        return label
    }()
    
    private let optionLabel: CustomLabel = {
        let label = CustomLabel(text: "Что будем делать?", fontWeight: .medium)
        return label
    }()
    
    private let infoLabel: CustomLabel = {
        let label = CustomLabel(text: "Опишите вашу проблему", fontWeight: .medium)
        return label
    }()
    
    private let imgLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить фото"
        label.font = UIFont(name: Const.fontSemi, size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    
    //MARK: - TextFields
    private let userCarField: CustomTextField = {
        let field = CustomTextField(placeholder: "Из спика ваших автомобилей")
        return field
    }()
    
    private let dateTF: UITextField = {
       let textField = UITextField()
        return textField
    }()
    
    private let optionField: CustomTextField = {
        let field = CustomTextField(placeholder: "Выберите из списка")
        return field
    }()
    
    private let infoField: CustomTextField = {
        let field = CustomTextField(placeholder: "Ваше сообщение")
        return field
    }()
    
    
    //MARK: - Tables
    private lazy var userCarTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.isHidden = true
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        tableView.layer.cornerRadius = 8
        tableView.layer.zPosition = 1
        return tableView
    }()
    
    private lazy var optionTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.isHidden = true
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        tableView.layer.cornerRadius = 8
        tableView.layer.zPosition = 1
        return tableView
    }()
    
    //MARK: -  StackView
    private let photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    //MARK: - CustomView
    private let firstPhotoView: CustomPhotoView = {
        let photoView = CustomPhotoView()
        return photoView
    }()
    
    private let secondPhotoView: CustomPhotoView = {
        let photoView = CustomPhotoView()
        return photoView
    }()
    
    private let thirdPhotoView: CustomPhotoView = {
        let photoView = CustomPhotoView()
        return photoView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(nil, forKey: "firstPhotoUrl")
        UserDefaults.standard.set(nil, forKey: "secondPhotoUrl")
        UserDefaults.standard.set(nil, forKey: "thirdPhotoUrl")
        
        setupView()
    }
    
    
    private func setupView() {
        userCarField.inputView = UIView()
        optionField.inputView = UIView()
        
        userCarField.delegate = self
        optionField.delegate = self
        
        userCarTable.dataSource = self
        optionTable.dataSource = self
        
        userCarTable.delegate = self
        optionTable.delegate = self
        
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(backButton)
        contentView.addSubview(headingLabel)
        contentView.addSubview(userCarLabel)
        contentView.addSubview(userCarField)
        userCarField.addSubview(carModelChevronButton)
        optionField.addSubview(optionsChevronButton)
        contentView.addSubview(timeMarkLabel)
        contentView.addSubview(dateTF)
        contentView.addSubview(datePicker)
        contentView.addSubview(optionLabel)
        contentView.addSubview(optionField)
        contentView.addSubview(infoLabel)
        contentView.addSubview(infoField)
        contentView.addSubview(imgLabel)
        contentView.addSubview(photosStackView)
        photosStackView.addArrangedSubview(firstPhotoView)
        photosStackView.addArrangedSubview(secondPhotoView)
        photosStackView.addArrangedSubview(thirdPhotoView)
        contentView.addSubview(sendOrderButton)
        
        contentView.addSubview(userCarTable)
        contentView.addSubview(optionTable)
        
        carModelChevronButton.addTarget(self, action: #selector(chevronButtonTapped), for: .touchUpInside)
        optionsChevronButton.addTarget(self, action: #selector(chevronButtonTapped), for: .touchUpInside)
        firstPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        firstPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)
        secondPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        secondPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)
        thirdPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        thirdPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)
        
        
        setupContraints()
    }
    
    //MARK: - FetchDataMethod

//    private func getUserAutos(completion: @escaping () -> Void) {
//        print(#function)
//        let group = DispatchGroup()
//
//        group.enter()
//        ProfileAPI.userAutos(success: { [weak self] jsonData in
//            self?.userAutosData = jsonData
//            self?.userCarTable.reloadData()
//            group.leave()
//        }) { error in
//            print(error)
//            group.leave()
//        }
//        group.enter()
//        group.notify(queue: .main) {
//            completion()
//        }
//    }
    
    
    
    // MARK: - Private actions
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func addSendButtonTapped() {
        print("addSendButtonTapped")
    }
    
    @objc private func chevronButtonTapped(_ sender: UIButton) {
        print(#function)
        switch sender {
        case carModelChevronButton:
            if userCarField.isFirstResponder {
                userCarField.resignFirstResponder()
            } else {
                userCarField.becomeFirstResponder()
            }
        case optionsChevronButton:
            if optionField.isFirstResponder {
                optionField.resignFirstResponder()
            } else {
                optionField.becomeFirstResponder()
            }
        default:
            break
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
        photoView.carPhoto = UIImage(named: "empty-photo")!
        if photoView == firstPhotoView {
            fileURLArray.remove(at: 0)
        } else if photoView == secondPhotoView {
            fileURLArray.remove(at: 1)
        } else if photoView == thirdPhotoView {
            fileURLArray.remove(at: 2)
        }
        reloadCarPhotos()
    }
    
    private func reloadCarPhotos() {
        if fileURLArray.isEmpty {
            firstPhotoView.carPhoto = UIImage(named: "empty-photo")!
            secondPhotoView.carPhoto = UIImage(named: "empty-photo")!
            thirdPhotoView.carPhoto = UIImage(named: "empty-photo")!
            return
        }
        let firstPhotoData = try! Data(contentsOf: fileURLArray[0])
        firstPhotoView.carPhoto = UIImage(data: firstPhotoData)!
        if fileURLArray.count < 2 {
            secondPhotoView.carPhoto = UIImage(named: "empty-photo")!
            thirdPhotoView.carPhoto = UIImage(named: "empty-photo")!
            return
        }
        let secondPhotoData = try! Data(contentsOf: fileURLArray[1])
        secondPhotoView.carPhoto = UIImage(data: secondPhotoData)!
        if fileURLArray.count < 3 {
            thirdPhotoView.carPhoto = UIImage(named: "empty-photo")!
            return
        }
        let thirdPhotoData = try! Data(contentsOf: fileURLArray[2])
        thirdPhotoView.carPhoto = UIImage(data: thirdPhotoData)!
    }
}
//MARK: -  UITextFieldDalegate
extension TechnicalRecordVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField != userCarField || textField != optionField
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        userCarTable.isHidden = !userCarField.isEditing
        optionTable.isHidden = !optionField.isEditing
        
        if textField.subviews.contains(carModelChevronButton) {
            carModelChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        } else if textField.subviews.contains(optionsChevronButton) {
            optionsChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        userCarTable.isHidden = !userCarField.isEditing
        optionTable.isHidden = !optionField.isEditing
        
        if textField.subviews.contains(carModelChevronButton) {
            carModelChevronButton.transform = .identity
        } else if textField.subviews.contains(optionsChevronButton) {
            optionsChevronButton.transform = .identity
        }
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension TechnicalRecordVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case userCarTable:
            return testArray.count
        case optionTable:
            return testArray.count
        default:
            break
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .gray
        switch tableView {
        case userCarTable:
            cell.textLabel?.text = testArray[indexPath.row]
        case optionTable:
            cell.textLabel?.text = testArray[indexPath.row]
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        switch tableView {
        case userCarTable:
            let carMark = testArray[indexPath.row]
            userCarField.text = testArray[indexPath.row]
        case optionTable:
            let optionModel = testArray[indexPath.row]
            optionField.text = testArray[indexPath.row]
        default:
            break
        }
    }
}
    
    // MARK: - UIImagePickerControllerDelegate
    extension TechnicalRecordVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.editedImage] as? UIImage else { return }
            
            let data = image.jpegData(compressionQuality: 0.8)
            let documentUrl = getDocumentsDirectory()
                .appendingPathComponent(UUID().uuidString)
                .appendingPathExtension("jpg")
            try! data!.write(to: documentUrl)
            
            fileURLArray.append(documentUrl)
            
            print(documentUrl)
            
            dismiss(animated: true) { [weak self] in
                if let data = data, let image = UIImage(data: data) {
                    if self?.firstPhotoView.carPhoto == UIImage(named: "empty-photo") {
                        self?.firstPhotoView.carPhoto = image
                        UserDefaults.standard.set("\(documentUrl)", forKey: "firstPhotoUrl")
                    } else if self?.secondPhotoView.carPhoto == UIImage(named: "empty-photo") {
                        self?.secondPhotoView.carPhoto = image
                        UserDefaults.standard.set("\(documentUrl)", forKey: "secondPhotoUrl")
                    } else if self?.thirdPhotoView.carPhoto == UIImage(named: "empty-photo") {
                        self?.thirdPhotoView.carPhoto = image
                        UserDefaults.standard.set("\(documentUrl)", forKey: "thirdPhotoUrl")
                    }
                }
            }
        }
    }

// MARK: - Constraints
extension TechnicalRecordVC {
    
    private func setupContraints() {
        let lOffset = Const.lOffset
        let rOffset = Const.rOffset
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 55, height: 55))
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(backgroundView)
        }
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 23))
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(40)
        }
        
        headingLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        userCarLabel.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        userCarField.snp.makeConstraints { make in
            make.top.equalTo(userCarLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        carModelChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        
        userCarTable.snp.makeConstraints { make in
            make.top.equalTo(userCarField.snp.bottom).offset(4)
            make.height.equalTo(140)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        timeMarkLabel.snp.makeConstraints { make in
            make.top.equalTo(userCarField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(timeMarkLabel.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(lOffset)
        }
        optionLabel.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(10)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        optionField.snp.makeConstraints { make in
            make.top.equalTo(optionLabel.snp.bottom).offset(10)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        optionsChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
        }

        optionTable.snp.makeConstraints { make in
            make.top.equalTo(optionField.snp.bottom).offset(4)
            make.height.equalTo(140)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(optionField.snp.bottom).offset(10)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        infoField.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        imgLabel.snp.makeConstraints { make in
            make.top.equalTo(infoField.snp.bottom).offset(28)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        photosStackView.snp.makeConstraints { make in
            make.top.equalTo(imgLabel.snp.bottom).offset(28)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        firstPhotoView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        secondPhotoView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        thirdPhotoView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        
        sendOrderButton.snp.makeConstraints { make in
            make.top.equalTo(photosStackView.snp.bottom).offset(28)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-40)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
    }
}