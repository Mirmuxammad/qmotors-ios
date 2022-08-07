//
//  MaintenanceTableViewCell.swift
//  QMotors
//
//  Created by Temur Juraev on 07.08.2022.
//

import UIKit
import SnapKit

class MaintenanceTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "MaintenanceTableViewCell"
    
    // MARK: - UI Elements
    private let itemCellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        setupViews()
        setupConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func setupViews() {
        addSubview(itemCellLabel)
    }
    
    private func setupConstraints() {
        itemCellLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(11)
            make.left.equalToSuperview().offset(36)
        }
    }
    
    // MARK: - Public functions
    
    func cellListConfigure(name: String) {
        itemCellLabel.text = name
    }
    func imageConfiguration(image: String) {
         
    }
}





