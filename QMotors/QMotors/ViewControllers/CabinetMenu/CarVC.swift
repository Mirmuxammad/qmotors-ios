//
//  CarVC.swift
//  QMotors
//
//  Created by Akhrorkhuja on 26/07/22.
//

import UIKit
import SnapKit

class CarVC: BaseVC {
    // MARK: - Properties
    private var options = ["option 1", "option 2", "option 3", "option 4", "option 5", "option 6"]
    private var carMarkDataStore = [CarMark]()
    private var carModelDataStore = [CarModel]()
    private var carYearDataStore: [Int] = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let currentYear = Int(formatter.string(from: Date()))!
        var carYearArray = [Int]()
        for year in (1980...currentYear).reversed() {
            carYearArray.append(year)
        }
        return carYearArray
    }()
    private var carMarkId: Int? {
        didSet {
            guard let carMarkId = carMarkId else { return }
            activityIndicator.startAnimating()
            CarAPI.carModelListByMarkId(markId: carMarkId, success: { [weak self] carModels in
                self?.carModelDataStore = carModels
                self?.carModelOptionsTable.reloadData()
                self?.activityIndicator.stopAnimating()
            }) { [weak self] error in
                print(error)
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    private var carModelId: Int?
    private var fileURLArray: [URL] = [] {
        didSet {
            print(fileURLArray)
        }
    }
    private let cellIdentifier = "optionsTableCell"
    
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
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let backButton: SmallBackButton = {
        let button = SmallBackButton()
        button.setupAction(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Заполните форму"
        label.font = UIFont(name: Const.fontSemi, size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let carMarkLabel: CustomLabel = {
        let label = CustomLabel(text: "Марка автомобиля", fontWeight: .medium)
        return label
    }()
    
    private let carMarkField: CustomTextField = {
        let field = CustomTextField(placeholder: "Выберите марку автомобиля")
        return field
    }()
    
    private let carMarkChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
        return button
    }()
    
    private lazy var carMarkOptionsTable: UITableView = {
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
    
    private let carModelLabel: CustomLabel = {
        let label = CustomLabel(text: "Модель автомобиля", fontWeight: .medium)
        return label
    }()
    
    private let carModelField: CustomTextField = {
        let field = CustomTextField(placeholder: "Выберите модель автомобиля")
        return field
    }()
    
    private let carModelChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
        return button
    }()
    
    private lazy var carModelOptionsTable: UITableView = {
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
    
    private let carYearLabel: CustomLabel = {
        let label = CustomLabel(text: "Год выпуска", fontWeight: .medium)
        return label
    }()
    
    private let carYearField: CustomTextField = {
        let field = CustomTextField(placeholder: "Год выпуска автомобиля")
        return field
    }()
    
    private let carYearChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
        return button
    }()
    
    private lazy var carYearOptionsTable: UITableView = {
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
    
    private let mileageLabel: CustomLabel = {
        let label = CustomLabel(text: "Пробег", fontWeight: .medium)
        return label
    }()
    
    private let mileageField: CustomTextField = {
        let field = CustomTextField(placeholder: "Укажите пробег автомобиле", keyboardType: .decimalPad)
        return field
    }()
    
    private let carNumberLabel: CustomLabel = {
        let label = CustomLabel(text: "Номер", fontWeight: .medium)
        return label
    }()
    
    private let carNumberField: CustomTextField = {
        let field = CustomTextField(placeholder: "Укажите номер автомобиля", keyboardType: .asciiCapable)
        return field
    }()
    
    private let vinLabel: CustomLabel = {
        let label = CustomLabel(text: "VIN номер", fontWeight: .medium)
        return label
    }()
    
    private let vinField: CustomTextField = {
        let field = CustomTextField(placeholder: "Ваш VIN номер", keyboardType: .asciiCapable)
        return field
    }()
    
    private let imgLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить фото"
        label.font = UIFont(name: Const.fontSemi, size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
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
    
    private let addCarButton: ActionButton = {
        let button = ActionButton()
        button.setupTitle(title: "ДОБАВИТЬ АВТОМОБИЛЬ")
        button.setupButton(target: self, action: #selector(addCarButtonTapped))
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

        UserDefaults.standard.set(nil, forKey: "firstPhotoUrl")
        UserDefaults.standard.set(nil, forKey: "secondPhotoUrl")
        UserDefaults.standard.set(nil, forKey: "thirdPhotoUrl")
        
        activityIndicator.startAnimating()
        fetchDropdownData { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
        setupView()
    }
    
    // MARK: - Setup View
    private func setupView() {
        carMarkField.inputView = UIView()
        carModelField.inputView = UIView()
        carYearField.inputView = UIView()
        
        carMarkField.delegate = self
        carModelField.delegate = self
        carYearField.delegate = self
        
        carMarkOptionsTable.dataSource = self
        carModelOptionsTable.dataSource = self
        carYearOptionsTable.dataSource = self
        
        carMarkOptionsTable.delegate = self
        carModelOptionsTable.delegate = self
        carYearOptionsTable.delegate = self
        
        view.addSubview(activityIndicator)
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(backButton)
        contentView.addSubview(headingLabel)
        contentView.addSubview(carMarkLabel)
        contentView.addSubview(carMarkField)
        carMarkField.addSubview(carMarkChevronButton)
        contentView.addSubview(carModelLabel)
        contentView.addSubview(carModelField)
        carModelField.addSubview(carModelChevronButton)
        contentView.addSubview(carYearLabel)
        contentView.addSubview(carYearField)
        carYearField.addSubview(carYearChevronButton)
        contentView.addSubview(mileageLabel)
        contentView.addSubview(mileageField)
        contentView.addSubview(carNumberLabel)
        contentView.addSubview(carNumberField)
        contentView.addSubview(vinLabel)
        contentView.addSubview(vinField)
        contentView.addSubview(imgLabel)
        contentView.addSubview(photosStackView)
        photosStackView.addArrangedSubview(firstPhotoView)
        photosStackView.addArrangedSubview(secondPhotoView)
        photosStackView.addArrangedSubview(thirdPhotoView)
        contentView.addSubview(addCarButton)

        contentView.addSubview(carMarkOptionsTable)
        contentView.addSubview(carModelOptionsTable)
        contentView.addSubview(carYearOptionsTable)
        
        carMarkChevronButton.addTarget(self, action: #selector(chevronButtonTapped), for: .touchUpInside)
        carModelChevronButton.addTarget(self, action: #selector(chevronButtonTapped), for: .touchUpInside)
        carYearChevronButton.addTarget(self, action: #selector(chevronButtonTapped), for: .touchUpInside)
        firstPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        firstPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)
        secondPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        secondPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)
        thirdPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        thirdPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)

        
        setupConstraints()
    }
    
    // MARK: - Methods
    private func fetchDropdownData(completion: @escaping () -> Void) {
        print(#function)
        let group = DispatchGroup()
        
        group.enter()
        CarAPI.carMarkList(success: { [weak self] carMarks in
            self?.carMarkDataStore = carMarks
            self?.carMarkOptionsTable.reloadData()
            group.leave()
        }) { error in
            print(error)
            group.leave()
        }
        
        group.enter()
        CarAPI.carModelList(success: { [weak self] carModels in
            self?.carModelDataStore = carModels
            self?.carModelOptionsTable.reloadData()
            group.leave()
        }) { error in
            print(error)
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }

    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func chevronButtonTapped(_ sender: UIButton) {
        print(#function)
        switch sender {
        case carMarkChevronButton:
            if carMarkField.isFirstResponder {
                carMarkField.resignFirstResponder()
            } else {
                carMarkField.becomeFirstResponder()
            }
        case carModelChevronButton:
            if carModelField.isFirstResponder {
                carModelField.resignFirstResponder()
            } else {
                carModelField.becomeFirstResponder()
            }
        case carYearChevronButton:
            if carYearField.isFirstResponder {
                carYearField.resignFirstResponder()
            } else {
                carYearField.becomeFirstResponder()
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
        photoView.photo = UIImage(named: "empty-photo")!
        if photoView == firstPhotoView {
            fileURLArray.remove(at: 0)
        } else if photoView == secondPhotoView {
            fileURLArray.remove(at: 1)
        } else if photoView == thirdPhotoView {
            fileURLArray.remove(at: 2)
        }
        reloadCarPhotos()

    }
    
    @objc private func addCarButtonTapped() {
        print(#function)
        guard let carModelId = carModelId, let carYear = carYearField.text, let carMileage = mileageField.text, let carNumber = carNumberField.text, let vin = vinField.text else { return }
        guard let carYearInt = Int(carYear), let carMileageInt = Int(carMileage) else { return }
        activityIndicator.startAnimating()
        CarAPI.addCar(carModelId: carModelId, year: carYearInt, mileage: carMileageInt, number: carNumber, vin: vin, lastVisit: Date(), status: .active, success: { [weak self] result in
            self?.addCarPhoto(carId: result["id"].intValue, completion: { [weak self] in
                guard let strongSelf = self else { return }
                self?.activityIndicator.stopAnimating()
                [strongSelf.carMarkField, strongSelf.carModelField, strongSelf.carYearField, strongSelf.mileageField, strongSelf.carNumberField, strongSelf.vinField].forEach { $0.text?.removeAll() }
                [strongSelf.firstPhotoView, strongSelf.secondPhotoView, strongSelf.thirdPhotoView].forEach { $0.carPhoto = UIImage(named: "empty-photo")! }
                self?.router?.back()
            })
        }) { [weak self] error in
            print(error)
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func addCarPhoto(carId: Int, completion: @escaping () -> Void) {
        if fileURLArray.isEmpty {
            completion()
            return
        }
        CarAPI.addCarPhoto(carId: carId, fileURLArray: fileURLArray, success: { [weak self] result in
            self?.reloadCarPhotos()
            self?.fileURLArray = []
            completion()
        }) { error in
            print(error)
            completion()
        }
    }
    
    private func reloadCarPhotos() {
        if fileURLArray.isEmpty {
            firstPhotoView.photo = UIImage(named: "empty-photo")!
            secondPhotoView.photo = UIImage(named: "empty-photo")!
            thirdPhotoView.photo = UIImage(named: "empty-photo")!
            return
        }
        let firstPhotoData = try! Data(contentsOf: fileURLArray[0])
        firstPhotoView.photo = UIImage(data: firstPhotoData)!
        if fileURLArray.count < 2 {
            secondPhotoView.photo = UIImage(named: "empty-photo")!
            thirdPhotoView.photo = UIImage(named: "empty-photo")!
            return
        }
        let secondPhotoData = try! Data(contentsOf: fileURLArray[1])
        secondPhotoView.photo = UIImage(data: secondPhotoData)!
        if fileURLArray.count < 3 {
            thirdPhotoView.photo = UIImage(named: "empty-photo")!
            return
        }
        let thirdPhotoData = try! Data(contentsOf: fileURLArray[2])
        thirdPhotoView.photo = UIImage(data: thirdPhotoData)!
    }

}

// MARK: - UITextFieldDelegate
extension CarVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField != carModelField || textField != carMarkField || textField != carYearField
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        carMarkOptionsTable.isHidden = !carMarkField.isEditing
        carModelOptionsTable.isHidden = !carModelField.isEditing
        carYearOptionsTable.isHidden = !carYearField.isEditing
        
        if textField.subviews.contains(carMarkChevronButton) {
            carMarkChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        } else if textField.subviews.contains(carModelChevronButton) {
            carModelChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        } else if textField.subviews.contains(carYearChevronButton) {
            carYearChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        carMarkOptionsTable.isHidden = !carMarkField.isEditing
        carModelOptionsTable.isHidden = !carMarkField.isEditing
        carYearOptionsTable.isHidden = !carYearField.isEditing
        
        if textField.subviews.contains(carMarkChevronButton) {
            carMarkChevronButton.transform = .identity
        } else if textField.subviews.contains(carModelChevronButton) {
            carModelChevronButton.transform = .identity
        } else if textField.subviews.contains(carYearChevronButton) {
            carYearChevronButton.transform = .identity
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case carMarkOptionsTable:
            return carMarkDataStore.count
        case carModelOptionsTable:
            return carModelDataStore.count
        case carYearOptionsTable:
            return carYearDataStore.count
        default:
            break
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .gray
        switch tableView {
        case carMarkOptionsTable:
            cell.textLabel?.text = carMarkDataStore[indexPath.row].name.uppercased()
        case carModelOptionsTable:
            cell.textLabel?.text = carModelDataStore[indexPath.row].name.uppercased()
        case carYearOptionsTable:
            cell.textLabel?.text = "\(carYearDataStore[indexPath.row])"
        default:
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        switch tableView {
        case carMarkOptionsTable:
            let carMark = carMarkDataStore[indexPath.row]
            carMarkField.text = carMark.name.uppercased()
            carMarkId = carMark.id
        case carModelOptionsTable:
            let carModel = carModelDataStore[indexPath.row]
            carModelField.text = carModel.name.uppercased()
            carModelId = carModel.id
        case carYearOptionsTable:
            carYearField.text = "\(carYearDataStore[indexPath.row])"
        default:
            break
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension CarVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
                if self?.firstPhotoView.photo == UIImage(named: "empty-photo") {
                    self?.firstPhotoView.photo = image
                    UserDefaults.standard.set("\(documentUrl)", forKey: "firstPhotoUrl")
                } else if self?.secondPhotoView.photo == UIImage(named: "empty-photo") {
                    self?.secondPhotoView.photo = image
                    UserDefaults.standard.set("\(documentUrl)", forKey: "secondPhotoUrl")
                } else if self?.thirdPhotoView.photo == UIImage(named: "empty-photo") {
                    self?.thirdPhotoView.photo = image
                    UserDefaults.standard.set("\(documentUrl)", forKey: "thirdPhotoUrl")
                }
            }
        }
    }
}

// MARK: - Constraints
extension CarVC {
    private func setupConstraints() {
        let lOffset = Const.lOffset
        let rOffset = Const.rOffset
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
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
        carMarkLabel.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carMarkField.snp.makeConstraints { make in
            make.top.equalTo(carMarkLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carMarkChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        carMarkOptionsTable.snp.makeConstraints { make in
            make.top.equalTo(carMarkField.snp.bottom).offset(4)
            make.height.equalTo(140)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carModelLabel.snp.makeConstraints { make in
            make.top.equalTo(carMarkField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carModelField.snp.makeConstraints { make in
            make.top.equalTo(carModelLabel.snp.bottom).offset(14)
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
        carModelOptionsTable.snp.makeConstraints { make in
            make.top.equalTo(carModelField.snp.bottom).offset(4)
            make.height.equalTo(140)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carYearLabel.snp.makeConstraints { make in
            make.top.equalTo(carModelField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carYearField.snp.makeConstraints { make in
            make.top.equalTo(carYearLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carYearChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        carYearOptionsTable.snp.makeConstraints { make in
            make.top.equalTo(carYearField.snp.bottom).offset(4)
            make.height.equalTo(140)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        mileageLabel.snp.makeConstraints { make in
            make.top.equalTo(carYearField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        mileageField.snp.makeConstraints { make in
            make.top.equalTo(mileageLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(mileageField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carNumberField.snp.makeConstraints { make in
            make.top.equalTo(carNumberLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        vinLabel.snp.makeConstraints { make in
            make.top.equalTo(carNumberField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        vinField.snp.makeConstraints { make in
            make.top.equalTo(vinLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        imgLabel.snp.makeConstraints { make in
            make.top.equalTo(vinField.snp.bottom).offset(28)
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
        addCarButton.snp.makeConstraints { make in
            make.top.equalTo(photosStackView.snp.bottom).offset(28)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-40)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
    }
}
