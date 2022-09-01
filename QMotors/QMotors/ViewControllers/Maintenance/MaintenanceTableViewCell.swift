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
    internal let backgroundViewCell: UIView = UIView()
    
    private let itemCellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat", size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let itemCellImage: UIImageView = {
        let image = UIImageView()
        
        return image
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
        addSubview(backgroundViewCell)
        backgroundViewCell.addSubview(itemCellLabel)
        backgroundViewCell.addSubview(itemCellImage)
    }
    
    private func setupConstraints() {
        backgroundViewCell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        itemCellImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(18.5)
            make.height.width.equalTo(32)
        }
        
        itemCellLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(itemCellImage.snp.right).offset(22)
            make.right.equalToSuperview().offset(-31)
        }
    }
    
    // MARK: - Public functions
    
    func cellConfig(cellName: String, cellImage: String) {
        itemCellLabel.text = cellName
        itemCellImage.image = UIImage(named: cellImage)
    }
}





