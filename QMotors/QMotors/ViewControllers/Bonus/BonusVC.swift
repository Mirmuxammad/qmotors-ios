//
//  BonusVC.swift
//  QMotors
//
//  Created by Mavlon on 24/08/22.
//

import UIKit
import SnapKit

class BonusVC: BaseVC {
    
    // MARK: - Properties
    
    var bonuses = [Bonus]()
    var balance = 0

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
        label.text = "Бонусы"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(MainBonusTableViewCell.self, forCellReuseIdentifier: MainBonusTableViewCell.identifier)
        tableView.register(BonusTableViewCell.self, forCellReuseIdentifier: BonusTableViewCell.identifier)
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        setupViews()
        setupConstraints()
        loadBonuses()
    }
    
    override func leftMenuButtonDidTap() {
        sideMenuVC.rootScreen = .techCenter
        super.leftMenuButtonDidTap()
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
            make.top.equalToSuperview().offset(40)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.height.equalTo(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(7)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    
    }
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // MARK: - Load bonuses
    
    private func loadBonuses() {
        activityIndicator.startAnimating()
        BonusAPI.bonusList { [weak self] bonusResponse in
            guard let self = self else { return }
            self.bonuses = bonusResponse.bonuses
            self.balance = bonusResponse.balance
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self.activityIndicator.stopAnimating()
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
extension BonusVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return bonuses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainBonusTableViewCell.identifier, for: indexPath) as? MainBonusTableViewCell else { return UITableViewCell() }
            cell.setupCell(with: balance)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BonusTableViewCell.identifier, for: indexPath) as? BonusTableViewCell
            else { return UITableViewCell() }
            cell.setupCell(with: bonuses[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 169
        default:
            return 112
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        default:
            return "Бонусы активны до 25 декабря 2022 года"
        }
    }
    
}

// MARK: - UITableViewDelegate
extension BonusVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt - \(indexPath.row)")
    }
}

