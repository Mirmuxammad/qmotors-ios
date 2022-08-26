//
//  NotificationTableViewCell.swift
//  QMotors
//
//  Created by Mavlon on 26/08/22.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "NotificationTableViewCell"
    
    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#5A80C0")
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bell-icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontSemi, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = "ПРОЧИТАННОЕ СООБЩЕНИЕ"
        return label
    }()
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 14)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "01.06.2022"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: Const.fontMed, size: 16)
        label.text = "Текст сообщения в 2 строчки продолжение открывается при ..."
        return label
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
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
        containerView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(descriptionLabel)
        horizontalStackView.addArrangedSubview(iconImageView)
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(dataLabel)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-25)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(23)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.width.equalTo(75)
        }
    }
    
    //MARK: - Public functions
    
    func setupCell(with balance: Int) {
        
    }

}
