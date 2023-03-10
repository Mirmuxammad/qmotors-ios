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

var isOpenedChat = false

enum RootScreen {
    case main
    case personalAccount
    case record
    case techCenter
    case stocks
    case notification
    case feedBack
    case chat
    case articles
    case FAQ
    case barcode
    case freeDiagnost
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
    
    func pushHelpVC() {
        let vc = HelpVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushArticleDeteil(id: Int) {
        let vc = ArticleDeteilViewController(id: id)
        pushViewController(vc: vc, animated: true)
    }
    
    func pushArticlesVC() {
        let vc = ArticlesViewController()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushAllFeedBAcks() {
        let vc = AllFeedBacksViewController()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushFeedBack() {
        let vc = FeedBackViewController()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushOrdersForCarVC(myCar: MyCarModel) {
        let vc = OrdersForCarVC(myCar: myCar)
        pushViewController(vc: vc, animated: true)
    }
    
    func pushOrdersForCarVC(myCar: MyCarModel, openAfterRecord: Bool) {
        let vc = OrdersForCarVC(myCar: myCar)
        vc.openedAfterRecordOrder = true
        pushViewController(vc: vc, animated: true)
    }
    
    func pushHistoryCarsVC() {
        let vc = HistoryCarsVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushMainVC() {
        let mainVC = MainVC()
        mainVC.router = self
        pushViewController(vc: mainVC, animated: true)
    }
        
    func pushRegistrationVC() {
        let vc = RegistrationVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushQRCodeVC() {
        let vc = QRCodeVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushCabinetVC() {
        let vc = CabinetVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushAddReminderVC() {
        let vc = AddReminderVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushEditReminderVC(reminder: NewReminder) {
        let vc = AddReminderVC()
        vc.reminder = reminder
        vc.openEditVC = true
        pushViewController(vc: vc, animated: true)
    }
    
    func pushMyRemindersVC(cars: [MyCarModel]) {
        let vc = MyRemindersVC()
        vc.myCars = cars
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
    
    func pushChatVC() {
        let vc = ChatVC()
        if !isOpenedChat {
            pushViewController(vc: vc, animated: true)
            isOpenedChat = true
        }
    }
    
    func pushProfileVC() {
        let vc = ProfileVC()
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
    
    func pushNotificationVC() {
        let vc = NotificationVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushCreateFeedBackVC() {
        let vc = CreateFeedBackVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushBonusVC() {
        let vc = BonusVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushTechnicalRecordVC() {
        let vc = OrderRecordVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushStockVC() {
        let vc = StockVC()
        pushViewController(vc: vc, animated: true)
    }
    
    func pushStockInfoVC(stock: Stock) {
        let vc = StockInfoVC()
        vc.stock = stock
        pushViewController(vc: vc, animated: true)
    }
    
    func pushAddStockVC(stock: Stock) {
        let vc = AddStockVC()
        vc.stock = stock
        pushViewController(vc: vc, animated: true)
    }
    
    func pushTechnicalRecordVCWhithID(id: Int) {
        let vc = OrderRecordVC(techCenterId: id)
        pushViewController(vc: vc, animated: true)
    }
    
    func pushCarInfoVC(carId: Int) {
        let vc = CarInfoVC(carId: carId)
        pushViewController(vc: vc, animated: true)
    }
    
    func pushCarVCForEdit(car: MyCarModel) {
        let vc = CarVC()
        vc.openEditCarVC = true
        vc.car = car
        pushViewController(vc: vc, animated: true)
    }
    
    func popEditCarVC() {
        let vc = MyCarsVC()
        navigationController.popToViewController(vc, animated: true)
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
