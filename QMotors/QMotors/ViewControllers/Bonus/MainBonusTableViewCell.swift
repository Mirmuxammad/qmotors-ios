//
//  MainBonusTableViewCell.swift
//  QMotors
//
//  Created by Mavlon on 25/08/22.
//

import UIKit

class MainBonusTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MainBonusTableViewCell"
    
    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#9CC55A")
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontSemi, size: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "На вашем счету"
        return label
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontBold, size: 70)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "150"
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "бонусных баллов"
        return label
    }()
    
    private let bonusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bonus")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#5A80C0")
        view.layer.cornerRadius = 290
        return view
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
        containerView.addSubview(circleView)
        containerView.addSubview(bonusImageView)
        containerView.addSubview(topLabel)
        containerView.addSubview(balanceLabel)
        containerView.addSubview(bottomLabel)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        circleView.snp.makeConstraints { make in
            make.width.height.equalTo(580)//(cellWidth * 1.7)
            make.centerY.equalTo(20)
            make.right.equalToSuperview().offset(-67)
        }
        
        bonusImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(7)
            make.right.equalToSuperview().offset(28)
            make.width.equalTo(177)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(22)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(-5)
            make.left.equalToSuperview().offset(22)
        }
        
    }

    
}
