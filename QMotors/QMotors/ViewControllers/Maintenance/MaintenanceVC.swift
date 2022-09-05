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
    
    private var baseView: MaintenanceView = MaintenanceView()
    private var services = [CarInspectionService]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.salonTableView.dataSource = self
        baseView.salonTableView.delegate = self
        
        baseView.hoodTableView.dataSource = self
        baseView.hoodTableView.delegate = self
        
        baseView.chassisTableView.dataSource = self
        baseView.chassisTableView.delegate = self
        
        services = [CarInspectionService(type: "САЛОН, ЭЛЕКТРИКА", icon: "car.lights", detailsForInsp: ["1 re re","2 buz buz","3","4"]), CarInspectionService(type: "ПОДКОПОТНОЕ ПРОСТРАНСТВО", icon: "car.hood", detailsForInsp: ["1","2","3","4"]),CarInspectionService(type: "ХОДОВАЯ(ПОДВЕСТКИ)", icon: "car.chassis", detailsForInsp: ["1","2","3","4"])]
        
        baseView.backButton.setupAction(target: self, action: #selector(backButtonDidTap))
        baseView.orderButton.setupButton(target: self, action: #selector(getOrder))
    }
    
    override func viewWillLayoutSubviews() {
        baseView.frame = view.bounds
        view.addSubview(baseView)
        baseView.configuration()
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
}


// MARK: - UITableViewDataSource, Delegate
extension MaintenanceVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == baseView.salonTableView {
            let sectionInsp = services[0]
            if sectionInsp.isOpened {
                baseView.salonTableView.snp.remakeConstraints { make in
                    make.height.equalTo(75 + section * 50)
                }
                return sectionInsp.detailsForInsp.count + 1
            } else {
                baseView.salonTableView.snp.remakeConstraints { make in
                    make.height.equalTo(75)
                }
                return 1
            }
        } else if tableView == baseView.hoodTableView {
            let sectionInsp = services[1]
            if sectionInsp.isOpened {
                baseView.hoodTableView.snp.remakeConstraints { make in
                    make.height.equalTo(75 + section * 50)
                }
                return sectionInsp.detailsForInsp.count + 1
            } else {
                baseView.hoodTableView.snp.remakeConstraints { make in
                    make.height.equalTo(75)
                }
                return 1
            }
        } else if tableView == baseView.chassisTableView {
            let sectionInsp = services[2]
            if sectionInsp.isOpened {
                baseView.chassisTableView.snp.remakeConstraints { make in
                    make.height.equalTo(75 + section * 50)
                }
                return sectionInsp.detailsForInsp.count + 1
            } else {
                baseView.chassisTableView.snp.remakeConstraints { make in
                    make.height.equalTo(75)
                }
                return 1
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == baseView.salonTableView {
            if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceTableViewCell.identifier, for: indexPath) as! MaintenanceTableViewCell
            let service = services[0]
            cell.cellConfig(cellName: service.type, cellImage: service.icon)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceDetailCell.identifier, for: indexPath) as! MaintenanceDetailCell
                let serviceName = services[0].detailsForInsp[indexPath.row - 1]
                print("Hello")
                cell.config(serviceName: serviceName)
                return cell
            }
        } else if tableView == baseView.hoodTableView {
            if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceTableViewCell.identifier, for: indexPath) as! MaintenanceTableViewCell
            let service = services[1]
            cell.cellConfig(cellName: service.type, cellImage: service.icon)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceDetailCell.identifier, for: indexPath) as! MaintenanceDetailCell
                let serviceName = services[1].detailsForInsp[indexPath.row - 1]
                cell.config(serviceName: serviceName)
                return cell
            }
        } else {
            if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceTableViewCell.identifier, for: indexPath) as! MaintenanceTableViewCell
            let service = services[2]
            cell.cellConfig(cellName: service.type, cellImage: service.icon)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceDetailCell.identifier, for: indexPath) as! MaintenanceDetailCell
                let serviceName = services[2].detailsForInsp[indexPath.row - 1]
                cell.config(serviceName: serviceName)
                return cell
            }
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
        print("taped")
        if tableView == baseView.salonTableView {
            services[0].isOpened = !services[0].isOpened
            tableView.reloadData()
            let height = services[0].isOpened ? (services[0].detailsForInsp.count * 50) : 0
            baseView.salonTableView.snp.remakeConstraints { make in
                make.height.equalTo(76 + height)
            }
        } else if tableView == baseView.hoodTableView {
            services[1].isOpened = !services[1].isOpened
            tableView.reloadData()
            let height = services[1].isOpened ? (services[1].detailsForInsp.count * 50) : 0
            baseView.hoodTableView.snp.remakeConstraints { make in
                make.height.equalTo(76 + height)
            }
        } else if tableView == baseView.chassisTableView {
            services[2].isOpened = !services[2].isOpened
            tableView.reloadData()
            let height = services[2].isOpened ? (services[2].detailsForInsp.count * 50) : 0
            baseView.chassisTableView.snp.remakeConstraints { make in
                make.height.equalTo(76 + height)
            }
        }
        
    }
    
}
