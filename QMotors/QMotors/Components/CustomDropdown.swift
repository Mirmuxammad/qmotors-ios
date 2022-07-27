//
//  CustomDropdown.swift
//  QMotors
//
//  Created by Akhrorkhuja on 26/07/22.
//

import UIKit
import SnapKit

class CustomDropdown: UITextField {
    // MARK: - Properties
    private var options = ["option 1", "option 2", "option 3", "option 4", "option 5", "option 6"]
    private let cellIdentifier = "optionsTableCell"
    
//    override var isSelected: Bool {
//        didSet {
//            optionsTable.isHidden = !isSelected
//        }
//    }
    
    // MARK: - UI Elements
    private lazy var optionsTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.flashScrollIndicators()
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private let optionField: CustomTextField = {
        let field = CustomTextField(placeholder: "Выберите марку автомобиля")
        field.inputView = .none
        return field
    }()
    
    // MARK: - Initialization
    init(options: [String]) {
        super.init(frame: .zero)
        self.options = options
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        optionsTable.dataSource = self
        optionsTable.delegate = self
        
        self.addSubview(optionsTable)
        
        setupConstraints()
    }
    
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CustomDropdown: UITableViewDelegate, UITableViewDataSource {
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
    }
}

// MARK: - Constraints
extension CustomDropdown {
    private func setupConstraints() {
        optionsTable.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom).offset(20)
            make.height.equalTo(200)
            make.left.right.equalToSuperview()
        }
    }
}
