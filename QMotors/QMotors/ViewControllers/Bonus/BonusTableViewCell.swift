//
//  BonusTableViewCell.swift
//  QMotors
//
//  Created by Mavlon on 25/08/22.
//

import UIKit

class BonusTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "BonusTableViewCell"
    
    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#ECECEC")
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blueView")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontBold, size: 40)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "400"
        return label
    }()
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 14)
        label.textAlignment = .left
        label.text = "01.06.2022"
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontBold, size: 14)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = "За установку приложения"
        return label
    }()
    
    private let stackView: UIStackView = {
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
        containerView.addSubview(rightImageView)
        containerView.addSubview(balanceLabel)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dataLabel)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.left.equalToSuperview()
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(109)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(24)
            make.right.equalTo(balanceLabel.snp.left)
        }
        
    }
    
    // MARK: - Public functions
    
    func setupCell(with bonus: Bonus) {
        
        titleLabel.text = bonus.title
        dataLabel.text = bonus.created_at.getFormattedDate()
        balanceLabel.text = String(bonus.points)
        
        switch bonus.bonus_type {
        case 2:
            rightImageView.image = UIImage(named: "redView")
            containerView.backgroundColor = UIColor.init(hex: "#ECECEC")
            titleLabel.textColor = .black
            dataLabel.textColor = .black
            
        default:
            rightImageView.image = UIImage(named: "blueView")
            containerView.backgroundColor = UIColor.init(hex: "#9CC55A")
            titleLabel.textColor = .white
            dataLabel.textColor = .white
        }
    }
    
    

}
