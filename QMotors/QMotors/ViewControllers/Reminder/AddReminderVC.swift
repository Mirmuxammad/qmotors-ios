//
//  AddReminderVC.swift
//  QMotors
//
//  Created by MIrmuxammad on 21/08/22.
//

import UIKit
import SnapKit
import DropDown


class AddReminderVC: BaseVC {
    
    
    private var myCars = [MyCarModel]()
    var reminder = NewReminder()
    var openEditVC = false
    

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
    
    private let sendReminderButton: ActionButton = {
        let button = ActionButton()
        button.setupTitle(title: "СОЗДАТЬ НАПОМИНАНИЕ")
        button.setupButton(target: self, action: #selector(addSendButtonTapped))
        button.isEnabled()
        return button
    }()
    
    private let myRemindersButton: ActionButton = {
        let button = ActionButton()
        button.setupButton(target: self, action: #selector(myRaminderButtonTapped))
        button.setupRemindersButton()
        button.setupTitle(title: "СПИСОК ВСЕХ НАПОМИНАНИЙ")
        return button
    }()
    
    //MARK: - Labels
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Напоминание"
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
        let label = CustomLabel(text: "Укажите дату и время напоминания", fontWeight: .medium)
        return label
    }()
    
    private let infoLabel: CustomLabel = {
        let label = CustomLabel(text: "Текст напоминание", fontWeight: .medium)
        return label
    }()
    
    //MARK: - TextFields
    
    private let userCarField: CustomTextField = {
        let field = CustomTextField(placeholder: "Из списка ваших автомобилей")
        return field
    }()
    
    private let dateTF: UITextField = {
       let textField = UITextField()
        return textField
    }()
    
    private let infoField: CustomTextField = {
        let field = CustomTextField(placeholder: "Ваше сообщение")
        return field
    }()
    
    //MARK: - Buttons for TextFields
    private let userCarButton: UIButton = UIButton()
    
    //MARK: - DropDowns
    
    private let userCarDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
    }()
    
    init() {
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoField.delegate = self
    
        datePicker.addTarget(self, action: #selector(setDate(picker:)), for: .valueChanged)
        userCarButton.addTarget(self, action: #selector(openDropDown(_:)), for: .touchUpInside)
        
        setupView()
    
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
        userCarField.inputView = UIView()
        
        userCarField.delegate = self
        
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(backButton)
        contentView.addSubview(headingLabel)
        contentView.addSubview(userCarLabel)
        contentView.addSubview(userCarField)
        contentView.addSubview(userCarButton)
        userCarField.addSubview(carModelChevronButton)
        contentView.addSubview(timeMarkLabel)
        contentView.addSubview(dateTF)
        contentView.addSubview(datePicker)
        contentView.addSubview(infoLabel)
        contentView.addSubview(infoField)
        contentView.addSubview(sendReminderButton)
        contentView.addSubview(myRemindersButton)
        
        setupContraints()
    }
    
    // MARK: - Private actions
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
            self?.reminder.user_car_id = id
            self?.userCarDropDown.hide()
            self?.carModelChevronButton.transform = .identity
            
        }
        
    }
   
    
    //MARK: - FetchDataMethod
    
    
    private func loadInfo() {
        self.showLoadingIndicator()
        let dg = DispatchGroup()
        loadMyCar(dg: dg)
        updateTableViews(dg: dg)
        if openEditVC == true {
            sendReminderButton.setupTitle(title: "РЕДАКТИРОВАТЬ")
        }
    }
    
    private func getInfoEdit() {
        myCars.map { i in
            if i.id == reminder.user_car_id {
                userCarField.text = i.model
                datePicker.date = (reminder.date?.getStringDate())!
                infoField.text = reminder.text
            }
        }
    }
    
    private func loadMyCar(dg: DispatchGroup) {
        dg.enter()
        CarAPI.getMyCars { [weak self] jsonData in
            guard let self = self else { return }
            self.myCars = jsonData
            if self.openEditVC == true {
                self.getInfoEdit()
            }
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
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func setDate(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: picker.date)
        reminder.date = dateString
    }
    
    @objc private func openDropDown(_ sender: UIButton) {
        userCarDropDown.show()
        carModelChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    @objc private func addSendButtonTapped() {
        self.showLoadingIndicator()
        
        if openEditVC == true {
            guard let id = reminder.id else { return }
            ReminderAPI.editReminder(reminderId: id, reminder: reminder) { json in
                self.dismissLoadingIndicator()
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                    self.router?.pushCabinetVC()
                }
            } failure: { error in
                let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                }))
                self.dismissLoadingIndicator()
                self.present(alert, animated: true, completion: nil)
            }
            
        } else if openEditVC == false {
            ReminderAPI.addNewReminder(reminder: reminder) { json in
                print(json)
                self.dismissLoadingIndicator()
                DispatchQueue.main.async {
                    self.router?.back()
                }
            } failure: { error in
                let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                }))
                self.dismissLoadingIndicator()
                self.present(alert, animated: true, completion: nil)
            }
        }
        openEditVC = false
    }
    
    @objc private func myRaminderButtonTapped() {
        router?.pushMyRemindersVC(cars: myCars)
    }

}
//MARK: -  UITextFieldDalegate
extension AddReminderVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == infoField {
            reminder.text = textField.text ?? "" + string
            return true
        }
        
        return textField != userCarField
    }
}
// MARK: - Constraints
extension AddReminderVC {
    
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
        
        userCarButton.snp.makeConstraints { make in
            make.edges.equalTo(userCarField)
        }
        
        carModelChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
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
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(10)
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
        
        sendReminderButton.snp.makeConstraints { make in
            make.top.equalTo(infoField.snp.bottom).offset(28)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        
        myRemindersButton.snp.makeConstraints { make in
            make.top.equalTo(sendReminderButton.snp.bottom).offset(28)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-40)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
    }
}
