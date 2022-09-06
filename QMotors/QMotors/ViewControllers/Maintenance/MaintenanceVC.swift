//
//  MaintenanceVC.swift
//  QMotors
//
//  Created by Temur Juraev on 07.08.2022.
//

import UIKit
import Alamofire

class CarInspectionService {
    let type: String
    let icon: String
    let detailsForInsp: [String]
    var isOpened: Bool = false
    
    init(type: String, icon: String, detailsForInsp: [String], isOpened: Bool = false) {
        self.type = type
        self.icon = icon
        self.detailsForInsp = detailsForInsp
        self.isOpened = isOpened
    }
}

class MaintenanceVC: BaseVC {
    
    // MARK: - UI Elements
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "small_logo")
        return imageView
    }()

    private let colorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "promo_background_button")
        imageView.frame.size = CGSize(width: 570, height: 150)
        return imageView
    }()
    
    //MARK: - TableView
    let salonTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        table.register(MaintenanceTableViewCell.self, forCellReuseIdentifier: MaintenanceTableViewCell.identifier)
        table.register(MaintenanceDetailCell.self, forCellReuseIdentifier: MaintenanceDetailCell.identifier)
        table.register(MaintenanceHeaderView.self, forHeaderFooterViewReuseIdentifier: MaintenanceHeaderView.identifier)
        table.register(MaintenanceFooterCell.self, forHeaderFooterViewReuseIdentifier: MaintenanceFooterCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var services = [CarInspectionService]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        salonTableView.dataSource = self
        salonTableView.delegate = self

        services = [CarInspectionService(type: "САЛОН, ЭЛЕКТРИКА", icon: "car.lights", detailsForInsp: ["1 re re","2 buz buz","3","4"]), CarInspectionService(type: "ПОДКОПОТНОЕ ПРОСТРАНСТВО", icon: "car.hood", detailsForInsp: ["1","2","3","4"]),CarInspectionService(type: "ХОДОВАЯ(ПОДВЕСТКИ)", icon: "car.chassis", detailsForInsp: ["1","2","3","4"])]
        
        setupViews()
        setupConstraints()
        
        salonTableView.sectionHeaderHeight = UITableView.automaticDimension
        salonTableView.estimatedSectionHeaderHeight = 350
    }
    
    // MARK: - Private actions
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    @objc private func getOrder() {
        print(#function)
        router?.pushMaintenanceOrderVC()
    }
    
    override func leftMenuButtonDidTap() {
        sideMenuVC.rootScreen = .techCenter
        super.leftMenuButtonDidTap()
    }
}


// MARK: - UITableViewDataSource, Delegate
extension MaintenanceVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: MaintenanceHeaderView.identifier) as! MaintenanceHeaderView
            cell.backButton.setupAction(target: self, action: #selector(backButtonDidTap))
            return cell
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 380
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: MaintenanceFooterCell.identifier) as! MaintenanceFooterCell
            cell.orderButton.setupButton(target: self, action: #selector(getOrder))
            return cell
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 125
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        services.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInsp = services[section]
        if sectionInsp.isOpened {
            return sectionInsp.detailsForInsp.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            print("im here")
            let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceTableViewCell.identifier, for: indexPath) as! MaintenanceTableViewCell
            let service = services[indexPath.section]
            cell.cellConfig(cellName: service.type, cellImage: service.icon)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceDetailCell.identifier, for: indexPath) as! MaintenanceDetailCell
            let serviceName = services[indexPath.section].detailsForInsp[indexPath.row - 1]
            print("Hello")
            cell.config(serviceName: serviceName)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 76
        } else {
            return 50
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        services[indexPath.section].isOpened = !services[indexPath.section].isOpened
        tableView.reloadData()
    }
    
}

extension MaintenanceVC {
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(salonTableView)
    }
    
    private func setupConstraints() {
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 55, height: 55))
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }

        salonTableView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.view.bounds.width)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
