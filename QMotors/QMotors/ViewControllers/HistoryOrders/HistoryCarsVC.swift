//
//  HistoryCarsVC.swift
//  QMotors
//
//  Created by Александр Гужавин on 10.08.2022.
//

import UIKit
import SnapKit

class HistoryCarsVC: BaseVC {
    
    var myCar = [MyCarModel]()
    
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
        label.text = "История"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let subTitleLable: UILabel = {
        let lable = UILabel()
        lable.text = "Выберите автомобиль для просмотра\nистории"
        lable.font = UIFont(name: "Montserrat-Regular", size: 16)
        lable.textColor = UIColor(red: 0.242, green: 0.242, blue: 0.242, alpha: 1)
        lable.textAlignment = .left
        lable.numberOfLines = 2
        return lable
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(MyCarsTableViewCell.self, forCellReuseIdentifier: MyCarsTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setupAction(target: self, action: #selector(backButtonDidTap))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMyCar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addViews()
        addConstraints()
    }
}
// MARK: - private Methods
extension HistoryCarsVC {
    private func loadMyCar() {
        self.showLoadingIndicator()
        CarAPI.getMyCarModel { [weak self] jsonData in
            guard let self = self else { return }
            self.myCar = jsonData
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

// MARK: - @objc Methods
@objc extension HistoryCarsVC {
    private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
}

// MARK: - @objc Methods
extension HistoryCarsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myCar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: MyCarsTableViewCell.identifier, for: indexPath) as? MyCarsTableViewCell
        else { return UITableViewCell() }
        
        cell.setupCell(myCar[indexPath.row])
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 160
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = myCar[indexPath.row]
        router?.pushOrdersForCarVC(myCar: car)
    }
    
}

// MARK: - Layout Subviews
extension HistoryCarsVC {
    private func addViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(subTitleLable)
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
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(40)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(backButton.snp.bottom).offset(20)
        }
        subTitleLable.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLable.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}


