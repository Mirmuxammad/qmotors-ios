//
//  MaintenanceOrderVC.swift
//  QMotors
//
//  Created by Temur Juraev on 07.08.2022.
//

import UIKit
import SnapKit
import DropDown

class MaintenanceOrderVC: BaseVC, UITextFieldDelegate {
    
    private var technicalCentersData = [TechnicalCenter]()
    private var myCars = [MyCarModel]()
    private var order = NewOrder()
    private var myCarOrder = MyCarOrder()
    
    var myCar: MyCarModel?
    
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
    
    private let thirdTitleLable: UILabel = {
        let label = UILabel()
        label.text = "Укажите дату и время"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let technicalCenterLable: CustomLabel = {
        let label = CustomLabel(text: "Технический центр", fontWeight: .medium)
        return label
    }()
    
    private let technicalCenterField: CustomTextField = {
        let field = CustomTextField(placeholder: "Выберите из списка")
        return field
    }()
    
    private let technicalCenterButton: UIButton = UIButton()
    
    private let technicalCenterDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
    }()
    
    private let technicalChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
        return button
    }()
    
    private let secondTitleLable: UILabel = {
        let label = UILabel()
        label.text = "Ваш автомобиль"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let userCarField: CustomTextField = {
        let field = CustomTextField(placeholder: "Из списка ваших автомобилей")
        return field
    }()
    
    private let userCarDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
    }()
    
    private let userCarButton: UIButton = UIButton()
    
    private let carModelChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        
        datePicker.addTarget(self, action: #selector(setDate(picker:)), for: .valueChanged)
        technicalCenterButton.addTarget(self, action: #selector(openDropDown(_:)), for: .touchUpInside)
        userCarButton.addTarget(self, action: #selector(openDropDown(_:)), for: .touchUpInside)
        sendOrderButton.setupButton(target: self, action: #selector(addSendButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadInfo()
    }
    
    
    // MARK: - Private actions
    
    @objc private func setDate(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: picker.date)
        order.date = dateString
        self.myCarOrder.lastVisit = picker.date
    }
    
    @objc private func openDropDown(_ sender: UIButton) {
        switch sender {
        case technicalCenterButton:
            technicalCenterDropDown.show()
            technicalChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        case userCarButton:
            userCarDropDown.show()
            carModelChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
        default:
            print(111)
        }
    }
    
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    private func loadInfo() {
        self.showLoadingIndicator()
        let dg = DispatchGroup()
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
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
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
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
            dg.leave()
        }
    }
    
    
    @objc private func addSendButtonTapped() {
        
        if order.date == nil {
            let alert = UIAlertController(title: "Ошибка", message: "Выберите дату записи на ТО", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else if order.techCenterId == nil {
            let alert = UIAlertController(title: "Ошибка", message: "Выберите технический центр", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else if myCar == nil {
            let alert = UIAlertController(title: "Ошибка", message: "Выберите автомобиль", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
        
            self.showLoadingIndicator()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let newDate = dateFormatter.date(from: order.date!)
            guard let car = myCar else { return }
            
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let lastVisitStr = formatter.string(from: newDate ?? Date())
            
            let orderDescroption = "Запись на бесплатную диагностику, через приложение"
            print("Tapped on button")

            OrderAPI.addDiagnosticOrder(carId: String(car.id), carNumber: car.number, techCenterId: order.techCenterId ?? 1, orderTypeId: 5, description: orderDescroption, dateVisit: lastVisitStr, freeDiagnostics: true, guarantee: false) { result in


            } failure: { error in
                print(error?.message ?? "")
                let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                }))
                self.dismissLoadingIndicator()
                self.present(alert, animated: true, completion: nil)
            }
            
            self.dismissLoadingIndicator()
            let alert = UIAlertController(title: "Успех", message: "Вы записаны на бесплатную диагностику", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.router?.back()
            }))
            present(alert, animated: true)
        }
        
    }
    
    
    private func updateTableViews(dg: DispatchGroup) {
        dg.notify(queue: .main) {
            self.setDropDowns()
            self.dismissLoadingIndicator()
        }
    }
    
    private func setDropDowns() {
        technicalCenterDropDown.dataSource = technicalCentersData.map({ i in
            i.title
        })
        userCarDropDown.dataSource = myCars.map({ i in
            i.mark + " " + i.model + " " + i.number
        })
        
        technicalCenterDropDown.anchorView = technicalCenterButton
        userCarDropDown.anchorView = userCarButton
        
        technicalCenterDropDown.direction = .bottom
        userCarDropDown.direction = .bottom
        
        technicalCenterDropDown.bottomOffset = CGPoint(x: 0, y:technicalCenterButton.frame.height + 10)
        userCarDropDown.bottomOffset = CGPoint(x: 0, y:userCarButton.frame.height + 10)
        
        technicalCenterDropDown.width = technicalCenterButton.frame.width
        userCarDropDown.width = userCarButton.frame.width
        
        technicalCenterDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.technicalCenterField.text = item
            self?.order.techCenterId = self?.technicalCentersData[index].id
            self?.technicalCenterDropDown.hide()
            self?.technicalChevronButton.transform = .identity
        }
        
        userCarDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.userCarField.text = item
            guard let id = self?.myCars[index].id else { return }
            guard let myCar = self?.myCars[index] else { return }
            self?.myCar = myCar
            self?.order.carId = String(id)
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
    }
    
    private func setupView() {
        userCarField.inputView = UIView()
        technicalCenterField.inputView = UIView()
        
        technicalCenterField.delegate = self
        userCarField.delegate = self
        
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(technicalCenterLable)
        backgroundView.addSubview(secondTitleLable)
        backgroundView.addSubview(thirdTitleLable)
        
        backgroundView.addSubview(technicalCenterField)
        backgroundView.addSubview(technicalCenterButton)
        technicalCenterField.addSubview(technicalChevronButton)
        
        backgroundView.addSubview(userCarField)
        backgroundView.addSubview(userCarButton)
        userCarField.addSubview(carModelChevronButton)
        
        backgroundView.addSubview(dateTF)
        backgroundView.addSubview(datePicker)
        backgroundView.addSubview(sendOrderButton)
        
        dateTF.inputView = datePicker
        userCarField.inputView = UIView()
        userCarField.delegate = self
        
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
        }
        
        technicalCenterLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.height.equalTo(22)
        }
        
        technicalCenterField.snp.makeConstraints { make in
            make.top.equalTo(technicalCenterLable.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        technicalCenterButton.snp.makeConstraints { make in
            make.edges.equalTo(technicalCenterField)
        }
        
        technicalChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        
        secondTitleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(technicalCenterField.snp.bottom).offset(24)
            make.height.equalTo(22)
        }
        
        userCarField.snp.makeConstraints { make in
            make.top.equalTo(secondTitleLable.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
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
        
        thirdTitleLable.snp.makeConstraints { make in
            make.top.equalTo(userCarField.snp.bottom).offset(20)
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
