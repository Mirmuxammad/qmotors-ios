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
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        
        blurView.isHidden = true
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(leftMenuButton)
        view.addSubview(chatsButton)
        view.addSubview(phoneCallButton)
        view.addSubview(logoImageView)
        view.addSubview(blurView)
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
        
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    // MARK: - Private actions
    
    @objc private func leftMenuButtonDidTap() {
        print("leftMenuButtonDidTap")
        router?.presentSideMenu(rootScreen: .mainScreen)
    }
    
    @objc private func chatsButtonDidTap() {
        print("chatsButtonDidTap")
    }
    
    @objc private func phoneCallButtonDidTap() {
        print("phoneCallButtonDidTap")
    }
    

}

extension BaseVC: SideMenuNavigationControllerDelegate {
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
        blurView.isHidden = false
    }
}
