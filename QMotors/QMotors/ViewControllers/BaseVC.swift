//
//  BaseVC.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 13.07.22.
//

import UIKit
import SnapKit
import SideMenu

class BaseVC: UIViewController, Routable {

    // MARK: - Properties
    
    var router: MainRouter?
    
    let sideMenuVC = SideMenuVC()
    
    // MARK: - UI elements
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "main_background")
        return imageView
    }()
    
    private let leftMenuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "left_menu_button"), for: .normal)
        button.addTarget(self, action: #selector(leftMenuButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let chatsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chats_button"), for: .normal)
        button.addTarget(self, action: #selector(chatsButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let phoneCallButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "phone_call_button"), for: .normal)
        button.addTarget(self, action: #selector(phoneCallButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "large_logo")
        return imageView
    }()
    
    private let blurView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#000000", alpha: 0.7)
        return view
    }()
    
    private let phoneCallButtonView = PhoneCallView()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHideKeyboardOnTapView()
        setupViews()
        setupConstraints()
    
        phoneCallButtonView.isHidden = true
        
       // addRightSwipeAction()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if touch?.view != phoneCallButtonView {
            blurBackgroundOff()
            phoneCallButtonView.isHidden = true
        }
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(leftMenuButton)
        view.addSubview(chatsButton)
        view.addSubview(phoneCallButton)
        view.addSubview(logoImageView)
        view.addSubview(leftMenuButton)
        view.addSubview(chatsButton)
        view.addSubview(phoneCallButton)
        view.addSubview(phoneCallButtonView)
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        leftMenuButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 36, height: 36))
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
        }
        
        chatsButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 36, height: 36))
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalTo(phoneCallButton.snp.left).offset(-10)
        }
        
        phoneCallButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 36, height: 36))
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 234, height: 99))
            make.top.equalTo(leftMenuButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        phoneCallButtonView.snp.makeConstraints { make in
            make.top.equalTo(phoneCallButton.snp.bottom)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 270, height: 270))
        }
        
    }
    
    private func blurBackgroundOn() {
        view.addSubview(blurView)
        view.bringSubviewToFront(leftMenuButton)
        view.bringSubviewToFront(chatsButton)
        view.bringSubviewToFront(phoneCallButton)
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func blurBackgroundOff() {
        blurView.removeFromSuperview()
    }
    
    private func blurViewIsHidden() -> Bool {
        if view.subviews.contains(blurView) {
            return false
        } else {
            return true
        }
    }
    
//    private func addRightSwipeAction() {
//        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
//        rightSwipe.direction = .right
//        view.addGestureRecognizer(rightSwipe)
//    }
    
    // MARK: - Private actions
    
    @objc func leftMenuButtonDidTap() {
        print("leftMenuButtonDidTap")
        sideMenuVC.router = router
       // sideMenuVC.rootScreen = .main
        let menu = SideMenuNavigationController(rootViewController: sideMenuVC)
        menu.leftSide = true
        menu.menuWidth = 260
        router?.navigationController.present(menu, animated: true, completion: nil)
    }
    
    @objc private func chatsButtonDidTap() {
        print("chatsButtonDidTap")
    }
    
    @objc private func phoneCallButtonDidTap() {
        print("phoneCallButtonDidTap")
        
        if blurViewIsHidden() && phoneCallButtonView.isHidden {
            blurBackgroundOn()
            view.bringSubviewToFront(phoneCallButtonView)
            phoneCallButtonView.isHidden = false
        } else {
            blurBackgroundOff()
            phoneCallButtonView.isHidden = true
        }
    }
    
//    @objc private func swipeHandler(_ gestureRecognizer: UISwipeGestureRecognizer) {
//        if gestureRecognizer.direction == .right {
//            router?.presentSideMenu(rootScreen: .main)
//        }
//    }
    
}

extension BaseVC: SideMenuNavigationControllerDelegate {
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        
        blurBackgroundOn()

        if !phoneCallButtonView.isHidden {
            phoneCallButtonView.isHidden = true
        }
        
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        blurBackgroundOff()
    }
}
