//
//  MainVC.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 13.07.22.
//

import UIKit
import SnapKit
import SideMenu

class MainVC: UIViewController, Routable {
    
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
    
    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let promoButton: MainScreenButton = {
        let button = MainScreenButton()
        button.backgroundColor = UIColor.init(hex: "#9CC55A")
        return button
    }()
    
    private let middleHorizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let maintenanceRecordButton: MainScreenButton = {
        let button = MainScreenButton()
        button.backgroundColor = UIColor.init(hex: "#5A80C0")
        return button
    }()
    
    private let bonusButton: MainScreenButton = {
        let button = MainScreenButton()
        button.backgroundColor = UIColor.init(hex: "#9CC55A")
        return button
    }()
    
    private let bottomHorizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let technicalСenterButton: MainScreenButton = {
        let button = MainScreenButton()
        button.backgroundColor = UIColor.init(hex: "#9CC55A")
        return button
    }()
    
    private let personalAreaButton: MainScreenButton = {
        let button = MainScreenButton()
        button.backgroundColor = UIColor.init(hex: "#5A80C0")
        return button
    }()
    
    private let blurView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#000000", alpha: 0.7)
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        
        setupButtons()
        blurView.isHidden = true
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        
        view.addSubview(backgroundImageView)
        view.addSubview(leftMenuButton)
        view.addSubview(chatsButton)
        view.addSubview(phoneCallButton)
        view.addSubview(logoImageView)
        
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(promoButton)
        verticalStack.addArrangedSubview(middleHorizontalStack)
        middleHorizontalStack.addArrangedSubview(maintenanceRecordButton)
        middleHorizontalStack.addArrangedSubview(bonusButton)
        verticalStack.addArrangedSubview(bottomHorizontalStack)
        bottomHorizontalStack.addArrangedSubview(technicalСenterButton)
        bottomHorizontalStack.addArrangedSubview(personalAreaButton)
        
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
        
        verticalStack.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height/2)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        
    }
    
    private func setupButtons() {
        
        guard
            let promoBackgroundButtonImage = UIImage(named: "promo_background_button"),
            let promoButtonImage = UIImage(named: "promo_button"),
            let maintenanceRecordButtonImage = UIImage(named: "maintenance_record_button"),
            let bonusButtonImage = UIImage(named: "bonus_button"),
            let technicalCenterButtonImage = UIImage(named: "technical_center_button"),
            let personalAreaButtonImage = UIImage(named: "personal_area_button")
        else { return }
        
        promoButton.setupButton(title: "АКЦИИ", target: self, action: #selector(promoButtonDidTap), logoImage: promoButtonImage, backgroundImage: promoBackgroundButtonImage)
        maintenanceRecordButton.setupButton(title: "ЗАПИСЬ", target: self, action: #selector(maintenanceRecordButtonDidTap), logoImage: maintenanceRecordButtonImage, backgroundImage: nil)
        bonusButton.setupButton(title: "БОНУСЫ", target: self, action: #selector(bonusButtonDidTap), logoImage: bonusButtonImage, backgroundImage: nil)
        technicalСenterButton.setupButton(title: "ТЕХЦЕНТРЫ", target: self, action: #selector(technicalСenterButtonDidTap), logoImage: technicalCenterButtonImage, backgroundImage: nil)
        personalAreaButton.setupButton(title: "ЛИЧНЫЙ КАБИНЕТ", target: self, action: #selector(personalAreaButtonDidTap), logoImage: personalAreaButtonImage, backgroundImage: nil)
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
    
    @objc private func promoButtonDidTap() {
        print("promoButtonDidTap")
    }
    
    @objc private func maintenanceRecordButtonDidTap() {
        print("maintenanceRecordButtonDidTap")
    }
    
    @objc private func bonusButtonDidTap() {
        print("bonusButtonDidTap")
    }
    
    @objc private func technicalСenterButtonDidTap() {
        print("technicalСenterButtonDidTap")
    }
    
    @objc private func personalAreaButtonDidTap() {
        print("personalAreaButtonDidTap")
    }
    
}

extension MainVC: SideMenuNavigationControllerDelegate {
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
        blurView.isHidden = false
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
        
        blurView.isHidden = true
    }
}
