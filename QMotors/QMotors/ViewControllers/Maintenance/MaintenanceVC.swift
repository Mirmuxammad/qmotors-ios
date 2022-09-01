//
//  MaintenanceVC.swift
//  QMotors
//
//  Created by Temur Juraev on 07.08.2022.
//

import UIKit
import SnapKit
import Alamofire

class MaintenanceVC: BaseVC {
    
    let list = ["САЛОН, ЭЛЕКТРИКА", "ПОДКОПОТНОЕ ПРОСТРАНСТВО", "ХОДОВАЯ(ПОДВЕСТКИ)"]
    let icons = ["mail.fill", "gearshape", "car.fill"]
    
    private var baseView: MaintenanceView = MaintenanceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.tableView.dataSource = self
        baseView.tableView.delegate = self
        
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
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceTableViewCell.identifier, for: indexPath) as! MaintenanceTableViewCell
        let name = list[indexPath.row]
        cell.cellConfig(cellName: name, cellImage: icons[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        76
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("didSelectRowAt - \(indexPath.row)")
//    }
    
}
