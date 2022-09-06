//
//  MaintenanceFooterCell.swift
//  QMotors
//
//  Created by Руслан Штыбаев on 06.09.2022.
//

import UIKit

class MaintenanceFooterCell: UITableViewHeaderFooterView {
    
    static let identifier = "TableFooter"

    let orderButton: ActionButton = {
        let button = ActionButton()
        button.setupTitle(title: "ЗАПИСАТЬСЯ")
        button.backgroundColor = UIColor(hex: "#9CC55A")
        button.frame.size = CGSize(width: 341, height: 55)
        button.isEnabled()
        return button
    }()
    
    
    
    
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "Для записи нужно авторизоваться"
        label.font = UIFont(name: "Montserrat", size: 14)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(orderButton)
        contentView.addSubview(informationLabel)
    }
    
    private func setupConstraints() {
    
        orderButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(orderButton.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
