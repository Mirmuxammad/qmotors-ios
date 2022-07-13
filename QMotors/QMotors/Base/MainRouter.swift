//
//  MainRouter.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 13.07.22.
//

import UIKit

protocol Routable: UIViewController {
    var router: MainRouter? { get set }
}

class MainRouter: NSObject {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(true, animated: true)
        self.navigationController = navigationController
    }
    
    func pushMainVC() {
        let mainVC = MainViewController()
        mainVC.router = self
        pushViewController(vc: mainVC, animated: true)
    }
    
    //Base
//    func start() {
//
//    }
    
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
