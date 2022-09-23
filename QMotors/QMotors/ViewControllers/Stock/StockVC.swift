//
//  StockVC.swift
//  QMotors
//
//  Created by MIrmuxammad on 06/09/22.
//

import UIKit
import SnapKit

class StockVC: BaseVC {

    // MARK: - Properties
    
    var stocks: [Stock] = []
    
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
        button.setupAction(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Акции"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.identifier)
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadStocks()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        
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
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func loadStocks() {
        activityIndicator.startAnimating()
        StockAPI.stockList { [weak self] jsonData in
            self?.stocks = jsonData
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    // MARK: - Private actions
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
}
// MARK: - UITableViewDataSource
extension StockVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier, for: indexPath) as? StockTableViewCell else { return UITableViewCell() }
        cell.setupCell(stock: stocks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if stocks[indexPath.row].location == nil && stocks[indexPath.row].title?.count ?? 0 <= 18 {
            return 125
        } else if stocks[indexPath.row].location == nil && stocks[indexPath.row].title?.count ?? 0 >= 18 {
            return 135
        } else {
            return 185
        }
    }
    
}
// MARK: - UITableViewDelegate
extension StockVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if UserDefaultsService.sharedInstance.authToken != nil {
            router?.pushStockInfoVC(stock: stocks[indexPath.row])
        } else {
            router?.pushRegistrationVC()
        }
        
    }
}
