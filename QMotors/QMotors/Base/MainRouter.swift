//
//  MainRouter.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 13.07.22.
//

import UIKit
import SideMenu

protocol Routable: UIViewController {
    var router: MainRouter? { get set }
}

enum RootScreen {
    case mainScreen
    case innerScreen
}

class MainRouter: NSObject {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(true, animated: true)
        self.navigationController = navigationController
    }
    
//    func pushBaseVC() {
//        let baseVC = BaseVC()
//        baseVC.router = self
//        pushViewController(vc: baseVC, animated: true)
//    }
    
    func pushMainVC() {
        let mainVC = MainVC()
        mainVC.router = self
        pushViewController(vc: mainVC, animated: true)
    }
        
    func pushRegistrationVC() {
        let vc = RegistrationVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushCabinetVC() {
        let vc = CabinetVC()
        pushViewController(vc: vc, animated: true)
    }
    
    //CabinetMenu
    func pushMyCarsVC() {
        let vc = MyCarsVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushCarVC() {
        let vc = CarVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushTechnicalCenterVC() {
        let vc = TechnicalCenterVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushMaintenanceOrderVC() {
        let vc = MaintenanceOrderVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushMaintenanceVC() {
        let vc = MaintenanceVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushTechnicalRecordVC() {
        let vc = TechnicalRecordVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushCarInfoVC(car: MyCarModel) {
        let vc = CarInfoVC()
        vc.car = car
        pushViewController(vc: vc, animated: true)
    }
    
    func pushEditCarVC(car: MyCarModel) {
        let vc = EditCarVC()
        vc.car = car
        pushViewController(vc: vc, animated: true)
    }
    
    func presentSideMenu(rootScreen: RootScreen) {
        let sideMenuVC = SideMenuVC()
        sideMenuVC.router = self
        sideMenuVC.rootScreen = rootScreen
        let menu = SideMenuNavigationController(rootViewController: sideMenuVC)
        menu.leftSide = true
        menu.menuWidth = 260
        navigationController.present(menu, animated: true, completion: nil)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    // MARK: - Private
    
    private func pushViewController(vc: Routable, animated: Bool) {
        vc.router = self
        navigationController.pushViewController(vc, animated: animated)
    }
    
    private func presentViewController(vc: Routable, animated: Bool) {
        vc.router = self
        vc.modalPresentationStyle = .popover
        navigationController.present(vc, animated: animated, completion: nil)
    }
    
//    private func showMainVC() {
//        pushViewController(vc: MainViewController(, animated: )
//    }

    
    
}
