//
//  TechnicalRecordVC.swift
//  QMotors
//
//  Created by Temur Juraev on 07.08.2022.
//

import UIKit
import SnapKit
import DropDown

class OrderRecordVC: BaseVC {
        
    private let cellIdentifier = "optionsTableCell"
    private var technicalCentersData = [TechnicalCenter]()
    private var myCars = [MyCarModel]()
    private var orderTypes = [OrderType]()
    private var order = NewOrder()
    private var myCarOrder = MyCarOrder()
    private var reminder = NewReminder()
    
    
    private var fileURLArray: [URL] = [] {
        didSet {
            print(fileURLArray.count)
        }
    }
    
    private var photos: [Data] = []
    
    private var carModelIdForUpdate: String = ""
    var myCar: MyCarModel?
    
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
        picker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        picker.minuteInterval = 10
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
    
    private let carChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
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
        button.setupTitle(title: "?????????????????? ????????????")
        button.setupButton(target: self, action: #selector(addSendButtonTapped))
        button.isEnabled()
        return button
    }()
    
    
    //MARK: - Labels
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "????????????????????"
        label.font = UIFont(name: Const.fontSemi, size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let technicalCenterLable: CustomLabel = {
        let label = CustomLabel(text: "????????????????????", fontWeight: .medium)
        return label
    }()
    
    private let userCarLabel: CustomLabel = {
        let label = CustomLabel(text: "?????? ????????????????????", fontWeight: .medium)
        return label
    }()
    
    private let userMilageLabel: CustomLabel = {
        let label = CustomLabel(text: "????????????", fontWeight: .medium)
        return label
    }()
    
    private let timeMarkLabel: CustomLabel = {
        let label = CustomLabel(text: "?????????????? ???????? ?? ??????????", fontWeight: .medium)
        return label
    }()
    
    private let optionLabel: CustomLabel = {
        let label = CustomLabel(text: "?????? ?????????? ?????????????", fontWeight: .medium)
        return label
    }()
    
    private let infoLabel: CustomLabel = {
        let label = CustomLabel(text: "?????????????? ???????? ????????????????", fontWeight: .medium)
        return label
    }()
    
    private let guaranteeInfoLabel: CustomLabel = {
        let label = CustomLabel(text: "?????????????? ???? ?? ?????? ????????????????", fontWeight: .medium)
        return label
    }()
    
    private let guaranteeSwitch: UISwitch = {
        let button = UISwitch()
        button.onTintColor = UIColor.init(hex: "#9CC55A")
        return button
    }()
    
    private let imgLabel: UILabel = {
        let label = UILabel()
        label.text = "???????????????? ????????"
        label.font = UIFont(name: Const.fontSemi, size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    
    //MARK: - TextFields
    private let technicalCenterField: CustomTextField = {
        let field = CustomTextField(placeholder: "???????????????? ???? ????????????")
        return field
    }()
    
    private let userCarField: CustomTextField = {
        let field = CustomTextField(placeholder: "???? ??????c???? ?????????? ??????????????????????")
        return field
    }()
    
    private let mileageField: CustomTextField = {
        let field = CustomTextField(placeholder: "?????????????? ???????????? ????????????????????")
        field.keyboardType = .numberPad
        return field
    }()
    
    private let dateTF: UITextField = {
       let textField = UITextField()
        return textField
    }()
    
    private let optionField: CustomTextField = {
        let field = CustomTextField(placeholder: "???????????????? ???? ????????????")
        return field
    }()
    
    private let infoField: CustomTextField = {
        let field = CustomTextField(placeholder: "???????? ??????????????????")
        return field
    }()
    
    //MARK: - Buttons for TextFields
    private let technicalCenterButton: UIButton = UIButton()
    private let userCarButton: UIButton = UIButton()
    private let optionButon: UIButton = UIButton()
    
    //MARK: - DropDowns
    private let technicalCenterDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
    }()
    
    private let userCarDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
    }()
    
    private let optionDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
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
    
    init(techCenterId: Int) {
        super .init(nibName: nil, bundle: nil)
        order.techCenterId = techCenterId
    }
    
    init() {
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(nil, forKey: "firstPhotoUrl")
        UserDefaults.standard.set(nil, forKey: "secondPhotoUrl")
        UserDefaults.standard.set(nil, forKey: "thirdPhotoUrl")
        
        infoField.delegate = self
    
        datePicker.addTarget(self, action: #selector(setDate(picker:)), for: .valueChanged)
        technicalCenterButton.addTarget(self, action: #selector(openDropDown(_:)), for: .touchUpInside)
        userCarButton.addTarget(self, action: #selector(openDropDown(_:)), for: .touchUpInside)
        optionButon.addTarget(self, action: #selector(openDropDown(_:)), for: .touchUpInside)
        order.guarantee = false
        setupView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadInfo()
    }
    
    override func leftMenuButtonDidTap() {
        sideMenuVC.rootScreen = .record
        super.leftMenuButtonDidTap()
    }
    
    
    private func setupView() {
        technicalCenterField.inputView = UIView()
        userCarField.inputView = UIView()
        optionField.inputView = UIView()
        
        technicalCenterField.delegate = self
        userCarField.delegate = self
        optionField.delegate = self
        
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(backButton)
        contentView.addSubview(headingLabel)
        contentView.addSubview(technicalCenterLable)
        contentView.addSubview(technicalCenterField)
        contentView.addSubview(technicalCenterButton)
        contentView.addSubview(userCarLabel)
        contentView.addSubview(userCarField)
        contentView.addSubview(userCarButton)
        technicalCenterField.addSubview(carChevronButton)
        userCarField.addSubview(carModelChevronButton)
        optionField.addSubview(optionsChevronButton)
        contentView.addSubview(userMilageLabel)
        contentView.addSubview(mileageField)
        contentView.addSubview(timeMarkLabel)
        contentView.addSubview(dateTF)
        contentView.addSubview(datePicker)
        contentView.addSubview(optionLabel)
        contentView.addSubview(optionField)
        contentView.addSubview(optionButon)
        contentView.addSubview(infoLabel)
        contentView.addSubview(infoField)
        contentView.addSubview(guaranteeInfoLabel)
        contentView.addSubview(guaranteeSwitch)
        contentView.addSubview(imgLabel)
        contentView.addSubview(photosStackView)
        photosStackView.addArrangedSubview(firstPhotoView)
        photosStackView.addArrangedSubview(secondPhotoView)
        photosStackView.addArrangedSubview(thirdPhotoView)
        contentView.addSubview(sendOrderButton)
        
        firstPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        firstPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)
        secondPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        secondPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)
        thirdPhotoView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        thirdPhotoView.removePhotoButton.addTarget(self, action: #selector(removePhotoButtonTapped), for: .touchUpInside)
        
        
        setupContraints()
    }
    
    //MARK: - FetchDataMethod
    
    private func loadInfo() {
        self.showLoadingIndicator()
        let dg = DispatchGroup()
        loadOrderTypes(dg: dg)
        loadMyCar(dg: dg)
        loadTechCenters(dg: dg)
        updateTableViews(dg: dg)
    }
    
    private func loadTechCenters(dg: DispatchGroup) {
        dg.enter()
        TechCenterAPI.techCenterList { [weak self] jsonData in
            guard let self = self else { return }
            self.technicalCentersData = jsonData
            dg.leave()
        } failure: { error in
            let alert = UIAlertController(title: "????????????", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
            dg.leave()
        }
        
    }
    
    
    private func loadOrderTypes(dg: DispatchGroup) {
        dg.enter()
        OrderAPI.orderTybeList { [weak self] jsonData in
            guard let self = self else { return }
            self.orderTypes = jsonData
            dg.leave()
        } failure: { error in
            let alert = UIAlertController(title: "????????????", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
            dg.leave()
        }
        
    }
    
    private func loadMyCar(dg: DispatchGroup) {
        dg.enter()
        CarAPI.getMyCars { [weak self] jsonData in
            guard let self = self else { return }
            self.myCars = jsonData.filter { $0.status == 0 }
            dg.leave()
        } failure: { error in
            let alert = UIAlertController(title: "????????????", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
            dg.leave()
        }
    }
    
    private func updateTableViews(dg: DispatchGroup) {
        dg.notify(queue: .main) {
            
            if let id = self.order.techCenterId {
                let centers = self.technicalCentersData.filter {$0.id == id}
                let centerName = centers.first?.title
                self.technicalCenterField.text = centerName
            }
            self.setDropDowns()
            self.dismissLoadingIndicator()
        }
    }
    
    private func addPhotoToOrder(orderId: Int) {
        
        OrderAPI.addPhotoToOrder(orderId: orderId, dataArray: photos, success: { [weak self] result in
            self?.fileURLArray = []
            self?.photos = []
//            self?.dismissLoadingIndicator()
        }) { error in
            self.dismissLoadingIndicator()
            print(error.debugDescription)
        }
    }
    
    // MARK: - Add reminder
    
    private func addReminder() {
        ReminderAPI.addNewReminder(reminder: reminder) { json in
            print(json)
        } failure: { error in
            let alert = UIAlertController(title: "???????????? ??????????????????????", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private actions
    private func setDropDowns() {
        technicalCenterDropDown.dataSource = technicalCentersData.map({ i in
            i.title
        })
        userCarDropDown.dataSource = myCars.map({ i in
            i.mark + " " + i.model + " " + (i.number ?? "")
        })
        
        optionDropDown.dataSource = orderTypes.map({ i in
            i.name
        })
        
        technicalCenterDropDown.anchorView = technicalCenterButton
        userCarDropDown.anchorView = userCarButton
        optionDropDown.anchorView = optionButon
        
        technicalCenterDropDown.direction = .bottom
        userCarDropDown.direction = .bottom
        optionDropDown.direction = .bottom
        
        technicalCenterDropDown.bottomOffset = CGPoint(x: 0, y:technicalCenterButton.frame.height + 10)
        userCarDropDown.bottomOffset = CGPoint(x: 0, y:userCarButton.frame.height + 10)
        optionDropDown.bottomOffset = CGPoint(x: 0, y:optionButon.frame.height + 10)
        
        technicalCenterDropDown.width = technicalCenterButton.frame.width
        userCarDropDown.width = userCarButton.frame.width
        optionDropDown.width = optionButon.frame.width
        
        
        technicalCenterDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.technicalCenterField.text = item
            self?.order.techCenterId = self?.technicalCentersData[index].id
            self?.technicalCenterDropDown.hide()
            self?.carChevronButton.transform = .identity
        }
        
        userCarDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.userCarField.text = item
            guard let id = self?.myCars[index].id else { return }
            guard let myCar = self?.myCars[index] else { return }
            self?.myCar = myCar
            self?.order.carId = String(id)
            self?.reminder.user_car_id = id
            self?.order.carNumber = self?.myCars[index].number
            self?.userCarDropDown.hide()
            self?.carModelChevronButton.transform = .identity
            
            self?.myCarOrder.id = id
            self?.myCarOrder.carModelId = self?.myCars[index].car_model_id
            self?.myCarOrder.year = self?.myCars[index].year
            guard let mileage = Int(self?.myCars[index].mileage ?? "") else { return }
            self?.myCarOrder.mileage = mileage
            self?.myCarOrder.vin = self?.myCars[index].vin
            self?.myCarOrder.number = self?.myCars[index].number
            self?.myCarOrder.status = CarStatus.active
        }
        
        optionDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.optionField.text = item
            self?.order.orderTypeId = self?.orderTypes[index].id
            
            self?.optionDropDown.hide()
            self?.optionsChevronButton.transform = .identity
        }
        
    }
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    private func updateLastVisit() {
        guard
            let id = myCarOrder.id,
            let carModelId = myCarOrder.carModelId,
            let year = myCarOrder.year,
            let milage = mileageField.text,
            let number = myCarOrder.number,
            let vin = myCarOrder.vin,
            let lastVisit = myCarOrder.lastVisit,
            let status = myCarOrder.status else { return }
        
        guard let intMileage = Int(milage) else { return }
    
        CarAPI.editCar(carId: id, carModelId: carModelId, year: year, mileage: intMileage, number: number, vin: vin, lastVisit: lastVisit, status: status) { [weak self] result in
            print("Car last visit succesfully updated")
        } failure: { error in
            self.showAlert(with: error?.localizedDescription ?? "????????????", buttonTitle: "????")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func addSendButtonTapped() {
        
        guard let orderDate = order.date else {
            let alert = UIAlertController(title: "????????????", message: "???????????????? ???????? ???????????? ???? ????", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        self.showLoadingIndicator()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let newDate = dateFormatter.date(from: orderDate)
        let visiteDate = dateFormatter.string(from: newDate ?? Date())
        
        guard let car = myCar,
              let orderTypeId = order.orderTypeId,
              let techCenterId = order.techCenterId else { return }
        
        var descriptionOfOrder = ""
        if let infoDescription = infoField.text {
            descriptionOfOrder = infoDescription
            self.reminder.text = infoDescription
        }
        
        var mileage = ""
        if let orderMileage = mileageField.text {
            mileage = orderMileage
        } else {
            mileage = car.mileage
        }
        
        let intMileage = Int(mileage) ?? 0
        
        let guarantee = guaranteeSwitch.isOn

        self.addReminder()
        OrderAPI.addDiagnosticOrder(carId: String(car.id), techCenterId: techCenterId, orderTypeId: orderTypeId, description: descriptionOfOrder, mileage: intMileage, dateVisit: visiteDate, freeDiagnostics: false, guarantee: guarantee,success: { [weak self] result in
            guard let self = self else { return }
            guard let orderId = result.result.id else { return }
            DispatchQueue.main.async {
                self.addPhotoToOrder(orderId: orderId)
                self.updateLastVisit()
                self.router?.pushOrdersForCarVC(myCar: car, openAfterRecord: true)
            }
            
            self.dismissLoadingIndicator()
            
        }) { [weak self] error in
            print(error?.message ?? "")
            let alert = UIAlertController(title: "????????????", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.dismissLoadingIndicator()
            self?.present(alert, animated: true, completion: nil)
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
            photos.remove(at: 0)
        } else if photoView == secondPhotoView {
            fileURLArray.remove(at: 1)
            photos.remove(at: 1)
        } else if photoView == thirdPhotoView {
            fileURLArray.remove(at: 2)
            photos.remove(at: 2)
        }
        reloadCarPhotos()
    }
    
    @objc private func setDate(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: picker.date)
        order.date = dateString
        self.myCarOrder.lastVisit = picker.date
        
        setDateReminder(picker: picker)
    }
    
    @objc private func setDateReminder(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let reminderDate = Calendar.current.date(byAdding: .day, value: -1, to: picker.date)
        let dateString = dateFormatter.string(from: reminderDate!)
        reminder.date = dateString
    }
    
    private func reloadCarPhotos() {
        if photos.isEmpty {
            firstPhotoView.photo = UIImage(named: "empty-photo")!
            secondPhotoView.photo = UIImage(named: "empty-photo")!
            thirdPhotoView.photo = UIImage(named: "empty-photo")!
            return
        }
//        let firstPhotoData = try! Data(contentsOf: fileURLArray[0])
        firstPhotoView.photo = UIImage(data: photos[0])!
        if photos.count < 2 {
            secondPhotoView.photo = UIImage(named: "empty-photo")!
            thirdPhotoView.photo = UIImage(named: "empty-photo")!
            return
        }
//        let secondPhotoData = try! Data(contentsOf: fileURLArray[1])
        secondPhotoView.photo = UIImage(data: photos[1])!
        if photos.count < 3 {
            thirdPhotoView.photo = UIImage(named: "empty-photo")!
            return
        }
//        let thirdPhotoData = try! Data(contentsOf: fileURLArray[2])
        thirdPhotoView.photo = UIImage(data: photos[2])!
    }
    
    @objc private func openDropDown(_ sender: UIButton) {
        
        switch sender {
        case technicalCenterButton:
            technicalCenterDropDown.show()
            carChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        case userCarButton:
            userCarDropDown.show()
            carModelChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        case optionButon:
            optionDropDown.show()
            optionsChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        default:
            print(111)
        }
    }
    
}
//MARK: -  UITextFieldDalegate
extension OrderRecordVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == infoField {
            order.description = textField.text ?? "" + string
            return true
        }
        
        return textField != userCarField || textField != optionField
    }
}

    // MARK: - UIImagePickerControllerDelegate
    extension OrderRecordVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.editedImage] as? UIImage/*, let selectedData = info[.editedImage] as? Data */else { return }
            let data = image.jpegData(compressionQuality: 0.8)
            let documentUrl = getDocumentsDirectory()
                .appendingPathComponent(UUID().uuidString)
                .appendingPathExtension("jpg")
            
            do {
                try data?.write(to: documentUrl)
            } catch {
                print(error)
            }
            
            fileURLArray.append(documentUrl)
            
            if let data = data {
                photos.append(data)
            }
            
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
extension OrderRecordVC {
    
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
            make.top.equalToSuperview().offset(20)
        }
        
        headingLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        technicalCenterLable.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        technicalCenterField.snp.makeConstraints { make in
            make.top.equalTo(technicalCenterLable.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        technicalCenterButton.snp.makeConstraints { make in
            make.edges.equalTo(technicalCenterField)
        }
        
        carChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        
        userCarLabel.snp.makeConstraints { make in
            make.top.equalTo(technicalCenterField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        userCarField.snp.makeConstraints { make in
            make.top.equalTo(userCarLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        userCarButton.snp.makeConstraints { make in
            make.edges.equalTo(userCarField)
        }
        
        carModelChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        
        userMilageLabel.snp.makeConstraints { make in
            make.top.equalTo(userCarField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        mileageField.snp.makeConstraints { make in
            make.top.equalTo(userMilageLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        timeMarkLabel.snp.makeConstraints { make in
            make.top.equalTo(mileageField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(timeMarkLabel.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(lOffset)
        }
        optionLabel.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        optionField.snp.makeConstraints { make in
            make.top.equalTo(optionLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        optionButon.snp.makeConstraints { make in
            make.edges.equalTo(optionField)
        }
        
        optionsChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(optionField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        infoField.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        guaranteeInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(infoField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        guaranteeSwitch.snp.makeConstraints { make in
            make.top.equalTo(guaranteeInfoLabel.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(lOffset)
        }
        
        imgLabel.snp.makeConstraints { make in
            make.top.equalTo(guaranteeSwitch.snp.bottom).offset(28)
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
