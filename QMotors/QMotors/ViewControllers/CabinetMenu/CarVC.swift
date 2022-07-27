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
    
    private let carMakeLabel: CustomLabel = {
        let label = CustomLabel(text: "Марка автомобиля", fontWeight: .medium)
        return label
    }()
    
    private let carMakeField: CustomTextField = {
        let field = CustomTextField(placeholder: "Выберите марку автомобиля")
        return field
    }()
    
    private lazy var carMakeOptionsTable: UITableView = {
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
    
    private let vinLabel: CustomLabel = {
        let label = CustomLabel(text: "VIN номер", fontWeight: .medium)
        return label
    }()
    
    private let vinField: CustomTextField = {
        let field = CustomTextField(placeholder: "Ваш VIN номер", keyboardType: .decimalPad)
        return field
    }()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK: - Setup View
    private func setupView() {
        carMakeField.inputView = UIView()
        carModelField.inputView = UIView()
        carYearField.inputView = UIView()
        
        carMakeField.delegate = self
        carModelField.delegate = self
        carYearField.delegate = self
        
        carMakeOptionsTable.dataSource = self
        carModelOptionsTable.dataSource = self
        carYearOptionsTable.dataSource = self
        
        carMakeOptionsTable.delegate = self
        carModelOptionsTable.delegate = self
        carYearOptionsTable.delegate = self
        
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(backButton)
        contentView.addSubview(headingLabel)
        contentView.addSubview(carMakeLabel)
        contentView.addSubview(carMakeField)
        contentView.addSubview(carModelLabel)
        contentView.addSubview(carModelField)
        contentView.addSubview(carYearLabel)
        contentView.addSubview(carYearField)
        contentView.addSubview(mileageLabel)
        contentView.addSubview(mileageField)
        contentView.addSubview(vinLabel)
        contentView.addSubview(vinField)
        contentView.addSubview(carMakeOptionsTable)
        contentView.addSubview(carModelOptionsTable)
        contentView.addSubview(carYearOptionsTable)
        
        setupConstraints()
    }
    
    // MARK: - Methods
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
}

// MARK: - UITextFieldDelegate
extension CarVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField != carModelField || textField != carMakeField || textField != carYearField
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        carMakeOptionsTable.isHidden = !carMakeField.isEditing
        carModelOptionsTable.isHidden = !carModelField.isEditing
        carYearOptionsTable.isHidden = !carYearField.isEditing
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        carMakeOptionsTable.isHidden = !carMakeField.isEditing
        carModelOptionsTable.isHidden = !carMakeField.isEditing
        carYearOptionsTable.isHidden = !carYearField.isEditing
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .gray
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        switch tableView {
        case carMakeOptionsTable:
            carMakeField.text = options[indexPath.row]
        case carModelOptionsTable:
            carModelField.text = options[indexPath.row]
        case carYearOptionsTable:
            carYearField.text = options[indexPath.row]
        default:
            break
        }
    }
}


// MARK: - Constraints
extension CarVC {
    private func setupConstraints() {
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
            make.top.bottom.width.height.equalTo(scrollView)
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
        carMakeLabel.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carMakeField.snp.makeConstraints { make in
            make.top.equalTo(carMakeLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carMakeOptionsTable.snp.makeConstraints { make in
            make.top.equalTo(carMakeField.snp.bottom).offset(4)
            make.height.equalTo(140)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carModelLabel.snp.makeConstraints { make in
            make.top.equalTo(carMakeField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        carModelField.snp.makeConstraints { make in
            make.top.equalTo(carModelLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
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
        vinLabel.snp.makeConstraints { make in
            make.top.equalTo(mileageField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
        vinField.snp.makeConstraints { make in
            make.top.equalTo(vinLabel.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(lOffset)
            make.right.equalToSuperview().offset(rOffset)
        }
    }
}
