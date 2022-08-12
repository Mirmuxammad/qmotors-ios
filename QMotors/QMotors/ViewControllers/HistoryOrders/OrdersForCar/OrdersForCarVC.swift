//
//  OrdersForCarVC.swift
//  QMotors
//
//  Created by Александр Гужавин on 10.08.2022.
//

import UIKit
import SnapKit


class OrdersForCarVC: BaseVC {
    
    private var myCar: MyCarModel
    
    private var ordersData = [Order]()
    
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
        label.text = "Заказ-наряды"
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
        tableView.layer.cornerRadius = 5
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
        self.showLoadingIndicator()
        loadOrders()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addViews()
        addConstraints()
    }
}
// MARK: - Other Methods
extension OrdersForCarVC {
    private func loadOrders() {
        OrderAPI.orderList(userCarId: myCar.id) { responce in
            let carOrders = responce.result
            guard let carOrder = carOrders.last else { return }
            self.ordersData = carOrder.orders
            self.tableView.reloadData()
            self.dismissLoadingIndicator()
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.dismissLoadingIndicator()
            self.present(alert, animated: true, completion: nil)
        }

    }
}

// MARK: - Objc Methods
@objc extension OrdersForCarVC {
    private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
}

// MARK: - @objc Methods
extension OrdersForCarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ordersData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCarsTableViewCell.identifier) as? MyCarsTableViewCell else { return UITableViewCell() }
            
            cell.setupCell(myCar)
            cell.backgroundColor = UIColor.init(hex: "#F8F8F8")
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderForCarTableViewCell.identifier) as? OrderForCarTableViewCell else { return UITableViewCell() }
        let order = ordersData[indexPath.row - 1]
        cell.setTitles(order: order)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(111)
    }
    
}

// MARK: - Layout Subviews
extension OrdersForCarVC {
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
            make.top.equalToSuperview().offset(40)
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
