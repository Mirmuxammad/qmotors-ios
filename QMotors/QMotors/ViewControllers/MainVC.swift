//
//  MainVC.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 18.07.22.
//

import UIKit
import SnapKit

class MainVC: BaseVC {
    
    // MARK: - UI Elements
    
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        
        setupButtons()
        
    }
    
    override func leftMenuButtonDidTap() {
        sideMenuVC.rootScreen = .main
        super.leftMenuButtonDidTap()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(promoButton)
        verticalStack.addArrangedSubview(middleHorizontalStack)
        middleHorizontalStack.addArrangedSubview(maintenanceRecordButton)
        middleHorizontalStack.addArrangedSubview(bonusButton)
        verticalStack.addArrangedSubview(bottomHorizontalStack)
        bottomHorizontalStack.addArrangedSubview(technicalСenterButton)
        bottomHorizontalStack.addArrangedSubview(personalAreaButton)
        
    }
    
    private func setupConstraints() {
        
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
    
    @objc private func promoButtonDidTap() {
        print("promoButtonDidTap")
        router?.pushStockVC()
    }
    
    @objc private func maintenanceRecordButtonDidTap() {        
        if UserDefaultsService.sharedInstance.authToken != nil {
            router?.pushTechnicalRecordVC()
        } else {
            router?.pushRegistrationVC()
        }
        
    }
    
    @objc private func bonusButtonDidTap() {
        print("bonusButtonDidTap")
        router?.pushBonusVC()
    }
    
    @objc private func technicalСenterButtonDidTap() {
        print("technicalСenterButtonDidTap")
        router?.pushTechnicalCenterVC()
    }
    
    @objc private func personalAreaButtonDidTap() {
        if UserDefaultsService.sharedInstance.authToken != nil {
            router?.pushCabinetVC()
        } else {
            router?.pushRegistrationVC()
        }
    }
}
