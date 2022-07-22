//
//  SideMenuTableViewCell.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 22.07.22.
//

import UIKit
import SnapKit

class SideMenuTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SideMenuTableViewCell"
    
    // MARK: - UI Elements
    
    private let itemCellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
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
    
    func cellSideMenuConfigure(name: String) {
        itemCellLabel.text = name
    }
}
