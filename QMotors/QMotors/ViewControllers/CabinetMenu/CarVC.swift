//
//  CarVC.swift
//  QMotors
//
//  Created by Akhrorkhuja on 26/07/22.
//

import UIKit
import SnapKit
import DropDown
import SDWebImage
import SwiftMaskText

class CarVC: BaseVC {
    
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
                self?.carModelOptionsDropDown.dataSource = (self?.carModelDataStore.map({ i in
                    i.name
                }))!
                self?.activityIndicator.stopAnimating()
            }) { [weak self] error in
                print(error)
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    private var carId: Int?
    private var carModelId: Int?
    private var fileURLArray: [URL] = [] {
        didSet {
            print(fileURLArray)
        }
    }
    
    private let cellIdentifier = "optionsTableCell"
    var openEditCarVC = false
    var car: MyCarModel?{
        didSet {
            if openEditCarVC == true {
                carMarkField.text = car?.mark
                carModelField.text = car?.model
                
                carYearField.text = "\(car?.year ?? 0)"
                mileageField.text = car?.mileage
                vinField.text = car?.vin
                carModelId = car?.car_model_id
                carId = car?.id
                carNumberField.text = car?.number
                carPhotos = car?.user_car_photos
                //loadCarPhotos = car?.user_car_photos
                fetchCarPhoto()
                
                addCarButton.setupTitle(title: "СОХРАНИТЬ")
                headingLabel.text = "Редактировать"
                lastVizit = car?.last_visit ?? "Визита не было"
            }
        }
    }
    var scrollOffset: CGFloat = 0
    var distance: CGFloat = 0
    var lastVizit: String = ""
    private var carPhotos: [CarPhoto]?

    
    
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
    
    private let carNumberField: SwiftMaskField = {
        let textField = SwiftMaskField()
        textField.maskString = "*NNN** NNN"
        textField.placeholder = "Укажите номер автомобиля"
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: Const.fontReg, size: 16)
        textField.autocapitalizationType = .allCharacters
        textField.keyboardType = .default
        textField.textColor = Const.fieldTextColor
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Const.fieldBorderColor.cgColor
        textField.addPadding(padding: .equalSpacing(16))
        textField.returnKeyType = .next
        return textField
    }()
    
    private let vinLabel: CustomLabel = {
        let label = CustomLabel(text: "VIN номер", fontWeight: .medium)
        return label
    }()
    
    private let vinField: CustomTextField = {
        let field = CustomTextField(placeholder: "Ваш VIN номер", keyboardType: .asciiCapable)
        field.autocapitalizationType = .allCharacters
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
        button.setupButton(target: self, action: #selector(addCarButtonTapped))
        button.setupTitle(title: "ДОБАВИТЬ АВТОМОБИЛЬ")
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
    
    //MARK: - Buttons for TextFields
    private let carModelOptionsButton: UIButton = UIButton()
    private let carMarkOptionsButton: UIButton = UIButton()
    private let carYearOptionsButon: UIButton = UIButton()
    
    //MARK: - DropDowns
    private let carModelOptionsDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
    }()
    
    private let carMarkOptionsDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
    }()
    
    private let carYearOptionsDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
    }()

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vinField.delegate = self

//        UserDefaults.standard.set(nil, forKey: "firstPhotoUrl")
//        UserDefaults.standard.set(nil, forKey: "secondPhotoUrl")
//        UserDefaults.standard.set(nil, forKey: "thirdPhotoUrl")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        activityIndicator.startAnimating()
        fetchDropdownData { [weak self] in
            self?.setDropDowns()
            
            if let car = self?.car, let carMarks = self?.carMarkDataStore {
                for mark in carMarks {
                    if mark.name == car.mark {
                        self?.carMarkId = mark.id
                    }
                }
            }
            self?.activityIndicator.stopAnimating()
        }
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup View
    private func setupView() {
        
        view.addSubview(activityIndicator)
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(backButton)
        contentView.addSubview(headingLabel)
        contentView.addSubview(carMarkLabel)
        contentView.addSubview(carMarkField)
        contentView.addSubview(carMarkOptionsButton)
        carMarkField.addSubview(carMarkChevronButton)
        contentView.addSubview(carModelLabel)
        contentView.addSubview(carModelField)
        contentView.addSubview(carModelOptionsButton)
        carModelField.addSubview(carModelChevronButton)
        contentView.addSubview(carYearLabel)
        contentView.addSubview(carYearField)
        contentView.addSubview(carYearOptionsButon)
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

        
        carMarkOptionsButton.addTarget(self, action: #selector(openDropDown(_:)), for: .touchUpInside)
        carModelOptionsButton.addTarget(self, action: #selector(openDropDown(_:)), for: .touchUpInside)
        carYearOptionsButon.addTarget(self, action: #selector(openDropDown(_:)), for: .touchUpInside)
        
        firstPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        firstPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)
        secondPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        secondPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)
        thirdPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        thirdPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)

        
        setupConstraints()
    }
    
    private func setDropDowns() {
        carMarkOptionsDropDown.dataSource = carMarkDataStore.map({ i in
            i.name
        })
        carModelOptionsDropDown.dataSource = carModelDataStore.map({ i in
            i.name
        })
        
        carYearOptionsDropDown.dataSource = carYearDataStore.map({ i in
            String(i)
        })
        
        carMarkOptionsDropDown.anchorView = carMarkOptionsButton
        carModelOptionsDropDown.anchorView = carModelOptionsButton
        carYearOptionsDropDown.anchorView = carYearOptionsButon
        
        carMarkOptionsDropDown.direction = .bottom
        carModelOptionsDropDown.direction = .bottom
        carYearOptionsDropDown.direction = .bottom
        
        carMarkOptionsDropDown.bottomOffset = CGPoint(x: 0, y:carMarkOptionsButton.frame.height + 10)
        carModelOptionsDropDown.bottomOffset = CGPoint(x: 0, y:carModelOptionsButton.frame.height + 10)
        carYearOptionsDropDown.bottomOffset = CGPoint(x: 0, y:carYearOptionsButon.frame.height + 10)
        
        carMarkOptionsDropDown.width = carMarkOptionsButton.frame.width
        carModelOptionsDropDown.width = carModelOptionsButton.frame.width
        carYearOptionsDropDown.width = carYearOptionsButon.frame.width
        
        
        carMarkOptionsDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.carMarkField.text = item
            guard let carMark = self?.carMarkDataStore[index] else { return }
            self?.carMarkId = carMark.id
            self?.carMarkOptionsDropDown.hide()
            self?.carMarkChevronButton.transform = .identity
        }
        
        carModelOptionsDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.carModelField.text = item
            guard let carModel = self?.carModelDataStore[index] else { return }
            self?.carModelId = carModel.id
            self?.carModelOptionsDropDown.hide()
            self?.carModelChevronButton.transform = .identity
        }
        
        carYearOptionsDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.carYearField.text = item
            self?.carYearOptionsDropDown.hide()
            self?.carYearChevronButton.transform = .identity
        }
    }
    
    // MARK: - Methods
    
    @objc private func openDropDown(_ sender: UIButton) {
        
        switch sender {
        case carMarkOptionsButton:
            carMarkOptionsDropDown.show()
            carMarkChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        case carModelOptionsButton:
            carModelOptionsDropDown.show()
            carModelChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        case carYearOptionsButon:
            carYearOptionsDropDown.show()
            carYearOptionsButon.transform = CGAffineTransform(rotationAngle: .pi)
        default:
            print(111)
        }
    }
    
    private func fetchDropdownData(completion: @escaping () -> Void) {
        print(#function)
        let group = DispatchGroup()
        
        group.enter()
        CarAPI.carMarkList(success: { [weak self] carMarks in
            self?.carMarkDataStore = carMarks
            group.leave()
        }) { error in
            print(error)
            group.leave()
        }
        
        group.enter()
        CarAPI.carModelList(success: { [weak self] carModels in
            self?.carModelDataStore = carModels
            group.leave()
        }) { error in
            print(error)
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    private func fetchCarPhoto() {
        if let carPhotos = self.carPhotos /*,let loadCarPhotos = self.loadCarPhotos*/ {
            for i in carPhotos {
                if let photo = URL(string: BaseAPI.baseURL + "\(i.photo)") {
                    fileURLArray.append(photo)
                }
            }
        }
        reloadCarPhotos()
    }
    
    private func deletePhoto(photoId: Int) {
        CarAPI.deleteCarPhoto(photoId: photoId) { result in
            print("photo delete success")
        } failure: { error in
            print(error?.localizedDescription)
        }
    }

    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func photoButtonTapped() {
        print(#function)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let galary = UIAlertAction(title: "Галерея", style: .default) { action in
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
        }
        let camera = UIAlertAction(title: "Камера", style: .default) { action in
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker, animated: true)
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(galary)
        alert.addAction(camera)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    @objc private func removePhotoButtonTapped(_ sender: UIButton) {
        print(#function)
        let photoView = sender.superview as! CustomPhotoView
        photoView.photo = UIImage(named: "empty-photo")!
        
        if photoView == firstPhotoView {
            fileURLArray.remove(at: 0)
            if(carPhotos!.count>0){
            deletePhoto(photoId: carPhotos?[0].id ?? 0)
                carPhotos?.remove(at: 0)}
        } else if photoView == secondPhotoView {
            fileURLArray.remove(at: 1)
            if(carPhotos!.count>1){
            deletePhoto(photoId: carPhotos?[1].id ?? 0)
            carPhotos?.remove(at: 1)
            }
            
        } else if photoView == thirdPhotoView {
            fileURLArray.remove(at: 2)
            //fileLocalArray.remove(at: 2)
            if(carPhotos!.count>2){
            deletePhoto(photoId: carPhotos?[2].id ?? 0)
                carPhotos?.remove(at: 2)}
        }
        print("🔴")
        print(fileURLArray.count)
        
        print("✅")
        print(carPhotos?.count)
        
        reloadCarPhotos()
    }
    
    @objc private func addCarButtonTapped() {
        print(#function)
        
        if openEditCarVC == true {
            guard let carId = carId, let carModelId = carModelId, let carYear = carYearField.text, let carMileage = mileageField.text,let carNumber = carNumberField.text, let vin = vinField.text else { return }
            guard let carYearInt = Int(carYear), let carMileageInt = Int(carMileage) else { return }
            activityIndicator.startAnimating()
            
            CarAPI.editCar(carId: carId,carModelId: carModelId, year: carYearInt, mileage: carMileageInt, number: carNumber, vin: vin, lastVisit: Date(), status: .active, success: { [weak self] result in
                
                
                self?.addCarPhoto(carId: result["id"].intValue, completion: { [weak self] in
                    print("🇺🇿")
                    print(self?.fileURLArray)
                    self?.activityIndicator.stopAnimating()
                    print("📍☎️")
                    print(self?.firstPhotoView.photo)
                    print(self?.secondPhotoView.photo)
                    print(self?.thirdPhotoView.photo)
                    guard let strongSelf = self else { return }
                    [strongSelf.carMarkField, strongSelf.carModelField,
                     strongSelf.carYearField, strongSelf.mileageField,
                     strongSelf.carNumberField, strongSelf.vinField].forEach { $0.text?.removeAll() }
                    [strongSelf.firstPhotoView, strongSelf.secondPhotoView, strongSelf.thirdPhotoView].forEach { $0.photo = UIImage(named: "empty-photo")! }
                    self?.openEditCarVC = false
                    print(#function)
                    
                    self?.activityIndicator.stopAnimating()
                    self?.openEditCarVC = false
                    self?.router?.back()
                })
            }) { [weak self] error in
                print(error)
                self?.activityIndicator.stopAnimating()
            }
        } else {
            guard let carModelId = carModelId, let carYear = carYearField.text, let carMileage = mileageField.text, let carNumber = carNumberField.text, let vin = vinField.text else { return }
            activityIndicator.stopAnimating()
            guard let carYearInt = Int(carYear), let carMileageInt = Int(carMileage) else { return }
            activityIndicator.startAnimating()
            CarAPI.addCar(carModelId: carModelId, year: carYearInt,
                          mileage: carMileageInt, number: carNumber,
                          vin: vin,
                          lastVisit: nil,
                          status: .active,
                          success: { [weak self] result in
                
                self?.addCarPhoto(carId: result["id"].intValue, completion: { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    guard let strongSelf = self else { return }
                    [strongSelf.carMarkField, strongSelf.carModelField,
                     strongSelf.carYearField, strongSelf.mileageField,
                     strongSelf.carNumberField, strongSelf.vinField].forEach { $0.text?.removeAll() }
                    [strongSelf.firstPhotoView, strongSelf.secondPhotoView, strongSelf.thirdPhotoView].forEach { $0.photo = UIImage(named: "empty-photo")! }
                    self?.openEditCarVC = false
                    print(#function)
                    self?.router?.back()
                })
                
            }) { [weak self] error in
                print(error)
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            var safeArea = self.view.frame
            safeArea.size.height += scrollView.contentOffset.y
            safeArea.size.height -= keyboardSize.height + (UIScreen.main.bounds.height*0.04)
            
            let activeField: CustomTextField? = [carMarkField, carModelField, carYearField,  mileageField,vinField].first { $0.isFirstResponder }
            if let activeField = activeField {
                if activeField == carModelField {
                    distance = activeField.frame.maxY / 1.42
                } else if activeField == carMarkField {
                    distance = activeField.frame.maxY / 2
                } else if activeField == carYearField {
                    distance = activeField.frame.maxY / 1.28
                } else if activeField == carNumberField {
                    distance = activeField.frame.maxY / 1.3
                } else if activeField == mileageField {
                    distance = activeField.frame.maxY / 1.3
                } else if activeField == vinField {
                    distance = activeField.frame.maxY / 1.3
                }
                self.scrollView.setContentOffset(CGPoint(x: 0, y: distance), animated: true)
            }
            scrollView.isScrollEnabled = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if distance == 0 {
            carModelChevronButton.transform = .identity
            carMarkChevronButton.transform = .identity
            carYearChevronButton.transform = .identity
            return
        }
        self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffset), animated: true)
        scrollOffset = 0
        distance = 0

    }
    
//    private func newfileURLs() -> [URL] {
//        var fileURls = [URL]()
//
//        if let carPhotos = self.carPhotos/*, let loadCarPhotos = self.loadCarPhotos*/ {
//            for i in carPhotos {
//                    if x.photo != i.photo {
//                        if let photo = URL(string: BaseAPI.baseURL + "\(i.photo)") {
//                            fileURls.append(photo)
//                    }
//                }
//            }
//        }
//        return fileURls
//    }
    
    private func addCarPhoto(carId: Int, completion: @escaping () -> Void) {
        print(#function)
        if fileURLArray.isEmpty {
            completion()
            return
        }
                
        let uploadFiles = fileURLArray.filter({!$0.absoluteString.contains("user_car")})
        if uploadFiles.isEmpty {
            completion()
            return
        }
        CarAPI.addCarPhoto(carId: carId, fileURLArray: uploadFiles, success: { [weak self] result in
            self?.reloadCarPhotos()
            self?.fileURLArray = []
            completion()
        }) { error in
            print(error)
            completion()
        }
    }
    
    private func reloadCarPhotos() {
        print("😡")
        print(fileURLArray)
        firstPhotoView.photo = UIImage(named: "empty-photo")!
        secondPhotoView.photo = UIImage(named: "empty-photo")!
        thirdPhotoView.photo = UIImage(named: "empty-photo")!

        if(!fileURLArray.isEmpty){
        for i in 0 ... fileURLArray.count-1
        {
            if(i == 0){firstPhotoView.removePhotoButton.isHidden = false
                firstPhotoView.imageView.sd_setImage(with: fileURLArray[i])}
            if(i == 1){
                secondPhotoView.removePhotoButton.isHidden = false
                secondPhotoView.imageView.sd_setImage(with: fileURLArray[i])}
            if(i == 2){
                thirdPhotoView.removePhotoButton.isHidden = false
                thirdPhotoView.imageView.sd_setImage(with: fileURLArray[i])}
        }}
        
        
//        if fileURLArray.isEmpty {
//            firstPhotoView.photo = UIImage(named: "empty-photo")!
//            secondPhotoView.photo = UIImage(named: "empty-photo")!
//            thirdPhotoView.photo = UIImage(named: "empty-photo")!
//        } else if fileURLArray.count == 1 {
//            let firstPhotoData = try! Data(contentsOf: fileURLArray[0])
//            firstPhotoView.photo = UIImage(data: firstPhotoData)!
//            secondPhotoView.photo = UIImage(named: "empty-photo")!
//            thirdPhotoView.photo = UIImage(named: "empty-photo")!
//
//        } else if fileURLArray.count == 2 {
//            let firstPhotoData = try! Data(contentsOf: fileURLArray[0])
//            firstPhotoView.photo = UIImage(data: firstPhotoData)!
//            let secondPhotoData = try! Data(contentsOf: fileURLArray[1])
//            secondPhotoView.photo = UIImage(data: secondPhotoData)!
//
//            thirdPhotoView.photo = UIImage(named: "empty-photo")!
//
//        } else if fileURLArray.count >= 3 {
//            let firstPhotoData = try! Data(contentsOf: fileURLArray[0])
//            firstPhotoView.photo = UIImage(data: firstPhotoData)!
//            let secondPhotoData = try! Data(contentsOf: fileURLArray[1])
//            secondPhotoView.photo = UIImage(data: secondPhotoData)!
//            let thirdPhotoData = try! Data(contentsOf: fileURLArray[2])
//            thirdPhotoView.photo = UIImage(data: thirdPhotoData)!
//
//        }

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
        
        if(!fileURLArray.isEmpty){
        for i in 0 ... fileURLArray.count-1
        {
            if(i == 0){firstPhotoView.removePhotoButton.isHidden = false
                firstPhotoView.imageView.sd_setImage(with: fileURLArray[i])}
            if(i == 1){
                secondPhotoView.removePhotoButton.isHidden = false
                secondPhotoView.imageView.sd_setImage(with: fileURLArray[i])}
            if(i == 2){
                thirdPhotoView.removePhotoButton.isHidden = false
                thirdPhotoView.imageView.sd_setImage(with: fileURLArray[i])}
        }}
        
        print(documentUrl)
        dismiss(animated: true)
        
//        dismiss(animated: true) { [weak self] in
//            if let data = data, let image = UIImage(data: data) {
//                if self?.firstPhotoView.photo == UIImage(named: "empty-photo") {
//                    self?.firstPhotoView.photo = image
//                    //UserDefaults.standard.set("\(documentUrl)", forKey: "firstPhotoUrl")
//                } else if self?.secondPhotoView.photo == UIImage(named: "empty-photo") {
//                    self?.secondPhotoView.photo = image
//                    //UserDefaults.standard.set("\(documentUrl)", forKey: "secondPhotoUrl")
//                } else if self?.thirdPhotoView.photo == UIImage(named: "empty-photo") {
//                    self?.thirdPhotoView.photo = image
//                    //UserDefaults.standard.set("\(documentUrl)", forKey: "thirdPhotoUrl")
//                }
//            }
//        }
    }
}

//MARK: - UITextFieldDelegate
extension CarVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        if textField == vinField {
            return count <= 17
        } else {
            return true
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
            make.top.equalToSuperview().offset(20)
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
        
        carMarkOptionsButton.snp.makeConstraints { make in
            make.edges.equalTo(carMarkField)
        }
        carMarkChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
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
        carModelOptionsButton.snp.makeConstraints { make in
            make.edges.equalTo(carModelField)
        }
        carModelChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
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
        carYearOptionsButon.snp.makeConstraints { make in
            make.edges.equalTo(carYearField)
        }
        carYearChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
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
