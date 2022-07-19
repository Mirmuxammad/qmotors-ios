//
//  AppCoordinator.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 13.07.22.
//

import UIKit

class AppCoordinator: NSObject {
    
    var window: UIWindow
    var router: MainRouter?
    
    init(window: UIWindow?) {
        self.window = window!
        super.init()
        startScreenFlow()
    }
    
    func didFinishLaunchingWithOptions(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
    }
    
    private func startScreenFlow() {
        let navController = UINavigationController()
        router = MainRouter(navigationController: navController)

        router?.pushRegistrationVC()
        
        
        self.window.rootViewController = navController
        self.window.makeKeyAndVisible()
    }
    
    
}
