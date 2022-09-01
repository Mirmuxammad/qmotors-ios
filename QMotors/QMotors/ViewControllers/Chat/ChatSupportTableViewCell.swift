//
//  ChatSupportTableViewCell.swift
//  QMotors
//
//  Created by Mavlon on 01/09/22.
//

import UIKit

class ChatSupportTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "ChatSupportTableViewCell"
    
    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
        view.backgroundColor = UIColor(hex: "5A80C0")
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chatLogo")
        return imageView
    }()
    
    private let chatLabel: UILabel = {
        let label = UILabel()
        label.text = "Здравствуйте, чем я могу вам помоч? Здравствуйте, чем я могу вам помоч"
        label.font = UIFont(name: Const.fontMed, size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 12)
        label.text = "12.10.2022  |  16:44"
        label.textColor = .black
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
        contentView.addSubview(logoImageView)
        contentView.addSubview(dateLabel)
        containerView.addSubview(chatLabel)
    }
    
    private func setupConstraints() {
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview()
            make.height.width.equalTo(34)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(logoImageView.snp.right).offset(6)
            make.bottom.equalTo(dateLabel.snp.top).offset(-4)
            make.right.equalToSuperview().offset(-50)
//            make.height.equalTo(100)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(6)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(22)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
        }
        
    }

}
