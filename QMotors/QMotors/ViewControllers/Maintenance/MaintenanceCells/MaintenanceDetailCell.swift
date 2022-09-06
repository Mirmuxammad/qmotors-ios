//
//  MaintenanceDetailCell.swift
//  QMotors
//
//  Created by Руслан Штыбаев on 01.09.2022.
//

import Foundation
import UIKit

class MaintenanceDetailCell: UITableViewCell {
    static let identifier = "MaintenanceDetailCell"
    
    private let labelDetail: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat", size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        setupViews()
        setupConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        addSubview(labelDetail)
    }
    
    private func setupConstraints() {
        labelDetail.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(19)
            make.right.equalToSuperview().offset(-19)
        }
    }
    
    func config(serviceName: String) {
        labelDetail.text = serviceName
    }
}

