//
//  MaintenanceHeaderViewCell.swift
//  QMotors
//
//  Created by Руслан Штыбаев on 05.09.2022.
//

import UIKit

class MaintenanceHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "TableHeader"
    
    private let introductionView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: 343, height: 150)
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.init(hex: "#9CC55A")
        return view
    }()
    
    private let colorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "promo_background_button")
        return imageView
    }()
    
    let backButton: SmallBackButton = {
        let button = SmallBackButton()
        return button
    }()
    
    // MARK: - Labels
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Бесплатная диагностика"
        label.numberOfLines = 0
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let secondTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Перечень услуг бесплатной диагностики"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let intdroductionLabel: UILabel = {
        let label = UILabel()
        label.text = "Здравствуйте!"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let intdroductionBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы рады предложить вам список услуг, на которые вы можете записаться совершенно бесплатно"
        label.font = UIFont(name: "Montserrat-Semibold", size: 16)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 4
        return label
    }()
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(backButton)
        contentView.addSubview(titleLable)
        contentView.addSubview(secondTitleLabel)
        contentView.addSubview(introductionView)
        
        introductionView.addSubview(colorImage)
        colorImage.addSubview(intdroductionLabel)
        colorImage.addSubview(intdroductionBottomLabel)
    }
    
    private func setupConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 23))
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.height.equalTo(22)
        }
        
        introductionView.snp.makeConstraints { make in
//            make.width.equalTo(343)
//            make.height.equalTo(150)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(titleLable.snp.bottom).offset(20)
        }
        
        secondTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(introductionView.snp.bottom).offset(30)
        }
        
        intdroductionLabel.snp.makeConstraints { make in
            make.left.equalTo(introductionView).offset(23)
            make.right.equalToSuperview().offset(-14)
            make.top.equalTo(introductionView).offset(20)
        }
        
        intdroductionBottomLabel.snp.makeConstraints { make in
            make.top.equalTo(intdroductionLabel.snp.bottom).offset(15)
            make.left.equalTo(introductionView).offset(22)
            make.right.equalTo(introductionView).offset(-14)
            make.bottom.equalToSuperview().offset(-19)
        }
        
        colorImage.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
    }
}
