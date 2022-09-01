//
//  MaintenanceView.swift
//  QMotors
//
//  Created by Руслан Штыбаев on 01.09.2022.
//

import Foundation
import UIKit

class MaintenanceView: UIView {
    
//    private let scrollView: UIScrollView = UIScrollView()
    
    // MARK: - UI Elements
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "small_logo")
        return imageView
    }()

    // MARK: - Views
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let introductionView: UIView = {
       let view = UIView()
        view.frame.size = CGSize(width: 343, height: 150)
        view.backgroundColor = UIColor.init(hex: "#9CC55A")
        return view
    }()
    
    private let colorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "promo_background_button")
        imageView.frame.size = CGSize(width: 570, height: 150)
        return imageView
    }()
    

    
    // MARK: - Buttons
    let backButton: SmallBackButton = {
        let button = SmallBackButton()
        return button
    }()
    
    let orderButton: ActionButton = {
        let button = ActionButton()
        button.setupTitle(title: "ЗАПИСАТЬСЯ")
        button.backgroundColor = UIColor(hex: "#9CC55A")
        button.frame.size = CGSize(width: 341, height: 55)
        button.isEnabled()
        return button
    }()
    
    // MARK: - Labels
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Бесплатная диагностика"
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
    
    private let informationLabel: UILabel = {
       let label = UILabel()
        label.text = "Для записи нужно авторизоваться"
        label.font = UIFont(name: "Montserrat", size: 14)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - TableView
    let tableView: UITableView = {
        let table = UITableView()
        table.isScrollEnabled = false
        table.register(MaintenanceTableViewCell.self, forCellReuseIdentifier: MaintenanceTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let carModelChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
        return button
    }()
    
    func configuration() {
        setupViews()
        setupConstraints()
    }
    
    
    
    private func setupViews() {
//        addSubview(scrollView)
        addSubview(logoImageView)
        addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(secondTitleLabel)
        backgroundView.addSubview(introductionView)
        backgroundView.addSubview(tableView)
        backgroundView.addSubview(orderButton)
        backgroundView.addSubview(informationLabel)
        colorImage.addSubview(intdroductionLabel)
        colorImage.addSubview(intdroductionBottomLabel)
        introductionView.addSubview(colorImage)
    }
    
    private func setupConstraints() {
        
//        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(logoImageView.snp.bottom).offset(20)
//            make.left.right.bottom.equalToSuperview()
//        }
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 55, height: 55))
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 23))
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(40)
        }
        
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.height.equalTo(22)
        }
        
        introductionView.snp.makeConstraints { make in
            make.width.equalTo(343)
            make.height.equalTo(150)
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
            make.left.equalTo(introductionView).offset(20)
            make.top.equalTo(introductionView).offset(20)
        }
        
        intdroductionBottomLabel.snp.makeConstraints { make in
            make.top.equalTo(intdroductionLabel.snp.bottom).offset(20)
            make.left.equalTo(introductionView).offset(20)
            make.right.equalTo(introductionView).offset(-20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(secondTitleLabel.snp.bottom).offset(5)
            make.right.left.equalToSuperview()
        }

        orderButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(28)
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(orderButton.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
