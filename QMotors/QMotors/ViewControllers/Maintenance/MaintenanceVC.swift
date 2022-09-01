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
        baseView.tableView.dataSource = self
        baseView.tableView.delegate = self
        baseView.tableView.estimatedRowHeight = 76
        baseView.tableView.rowHeight = UITableView.automaticDimension
        
        services = [CarInspectionService(type: "САЛОН, ЭЛЕКТРИКА", icon: "car.lights", detailsForInsp: ["1","2","3","4"]), CarInspectionService(type: "ПОДКОПОТНОЕ ПРОСТРАНСТВО", icon: "car.hood", detailsForInsp: ["1","2","3","4"]),CarInspectionService(type: "ХОДОВАЯ(ПОДВЕСТКИ)", icon: "car.chassis", detailsForInsp: ["1","2","3","4"])]
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceTableViewCell.identifier, for: indexPath) as! MaintenanceTableViewCell
        let service = services[indexPath.section]
        cell.cellConfig(cellName: service.type, cellImage: service.icon)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceDetailCell.identifier, for: indexPath) as! MaintenanceDetailCell
            let serviceName = services[indexPath.section].detailsForInsp[indexPath.row]
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
        tableView.deselectRow(at: indexPath, animated: true)
        
        services[indexPath.section].isOpened = !services[indexPath.section].isOpened
        tableView.reloadSections([indexPath.section], with: .none)
    }
    
}
