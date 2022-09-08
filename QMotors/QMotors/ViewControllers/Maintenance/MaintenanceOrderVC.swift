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
        
        userCarButton.addTarget(self, action: #selector(openDropDown), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadInfo()
    }
    
    
    // MARK: - Private actions
    
    @objc private func openDropDown() {
        userCarDropDown.show()
        carModelChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func sendOrder() {
        print(#function)
    }
    
    private func loadInfo() {
        self.showLoadingIndicator()
        let dg = DispatchGroup()
        loadMyCar(dg: dg)
        updateTableViews(dg: dg)
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
    
    private func updateTableViews(dg: DispatchGroup) {
        dg.notify(queue: .main) {
            self.setDropDowns()
            self.dismissLoadingIndicator()
        }
    }
    
    private func setDropDowns() {
        userCarDropDown.dataSource = myCars.map({ i in
            i.mark + " " + i.model + " " + i.number
        })
        userCarDropDown.anchorView = userCarButton
        userCarDropDown.direction = .bottom
        userCarDropDown.bottomOffset = CGPoint(x: 0, y:userCarButton.frame.height + 10)
        userCarDropDown.width = userCarButton.frame.width
        
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
        userCarField.delegate = self
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(secondTitleLable)
        backgroundView.addSubview(thirdTitleLable)
        
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
