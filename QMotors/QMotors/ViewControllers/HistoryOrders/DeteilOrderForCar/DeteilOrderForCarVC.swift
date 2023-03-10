//
//  DeteilOrderForCarVC.swift
//  QMotors
//
//  Created by Александр Гужавин on 11.08.2022.
//

import Foundation

import UIKit
import SnapKit


class DeteilOrderForCarVC: BaseVC {
    
    private var myCar: MyCarModel
    
    private var ordersData = [NewOrder]()
    
    // MARK: - UI Elements
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "small_logo")
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let backButton: SmallBackButton = {
        let button = SmallBackButton()
        return button
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Заказ-наряд"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 1, left: 24, bottom: 1, right: 24)
        tableView.register(OrderForCarTableViewCell.self, forCellReuseIdentifier: OrderForCarTableViewCell.identifier)
        tableView.register(MyCarsTableViewCell.self, forCellReuseIdentifier: MyCarsTableViewCell.identifier)
        return tableView
    }()
    
    init(myCar: MyCarModel) {
        self.myCar = myCar
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setupAction(target: self, action: #selector(backButtonDidTap))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(myCar.id)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addViews()
        addConstraints()
    }
}
// MARK: - Other Methods
extension DeteilOrderForCarVC {
    
}

// MARK: - Objc Methods
@objc extension DeteilOrderForCarVC {
    private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
}

// MARK: - @objc Methods
extension DeteilOrderForCarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCarsTableViewCell.identifier) as? MyCarsTableViewCell else { return UITableViewCell() }
            
            cell.setupCell(myCar)
            cell.backgroundColor = UIColor.init(hex: "#F8F8F8")
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderForCarTableViewCell.identifier) as? OrderForCarTableViewCell else { return UITableViewCell() }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(111)
    }
    
}

// MARK: - Layout Subviews
extension DeteilOrderForCarVC {
    private func addViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(tableView)
    }
    
    private func addConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 55, height: 55))
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 23))
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.height.equalTo(22)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
}

