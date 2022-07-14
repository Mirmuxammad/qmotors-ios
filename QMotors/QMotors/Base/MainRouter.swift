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
    
    //Base
//    func start() {
//
//    }
    
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
