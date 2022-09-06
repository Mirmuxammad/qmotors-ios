//
//  StockTableViewCell.swift
//  QMotors
//
//  Created by MIrmuxammad on 06/09/22.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    static let identifier = "StockTableViewCell"
    
    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#5A80C0")
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: Const.fontBold, size: 22)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Подробности акции, здесь краткое описание ации"
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MapPinLine")
        return imageView
    }()
        
    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontBold, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Субару"
        return label
    }()
    
    private let stockTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 3
        label.text = "Здесь будет текст напоминания, который ввел клиент при его создании"
        return label
    }()
    
    
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(locationImageView)
        containerView.addSubview(locationTitleLabel)
        containerView.addSubview(stockTextLabel)
        
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(24)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 32, height: 32))
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        locationTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationImageView.snp.centerY)
            make.left.equalTo(locationImageView.snp.right).offset(16)
            make.height.equalTo(14)
        }
        
        stockTextLabel.snp.makeConstraints { make in
            make.top.equalTo(locationImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
        
    // MARK: - Public functions
    
    func setupCell(stock: Stock) {
        titleLabel.text = stock.title
        if stock.location == nil {
            locationTitleLabel.text = "Неизвестно"
        } else {
            locationTitleLabel.text = stock.location
        }
        stockTextLabel.text = stock.subtitle
    }
   
    
}
