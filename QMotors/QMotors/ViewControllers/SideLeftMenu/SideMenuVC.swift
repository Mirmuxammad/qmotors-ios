//
//  SideMenuVC.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 13.07.22.
//

import UIKit
import SnapKit

class SideMenuVC: UIViewController, Routable {
    
    // MARK: - Properties
    
    var router: MainRouter?
    var rootScreen: RootScreen?
    
    // MARK: - UI elements
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "medium_logo")
        return imageView
    }()
    
    private let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private let personalAreaButton: SideMenuButton = {
        let button = SideMenuButton()
        button.setupButton(title: "ЛИЧНЫЙ КАБИНЕТ", target: self, action: #selector(personalAreaButtonDidTap))
        return button
    }()
    
    private let singInButton: SideMenuButton = {
        let button = SideMenuButton()
        button.setupButton(title: "ЗАПИСЬ", target: self, action: #selector(singInButtonDidTap))
        return button
    }()
    
    private let techCentersButton: SideMenuButton = {
        let button = SideMenuButton()
        button.setupButton(title: "ТЕХЦЕНТРЫ", target: self, action: #selector(techCentersButtonDidTap))
        return button
    }()
    
    private let promoButton: SideMenuButton = {
        let button = SideMenuButton()
        button.setupButton(title: "АКЦИИ", target: self, action: #selector(promoButtonDidTap))
        return button
    }()
    
    private let reminderButton: SideMenuButton = {
        let button = SideMenuButton()
        button.setupButton(title: "УВЕДОМЛЕНИЯ", target: self, action: #selector(reminderButtonDidTap))
        return button
    }()
    
    private let reviewsButton: SideMenuButton = {
        let button = SideMenuButton()
        button.setupButton(title: "ОТЗЫВЫ", target: self, action: #selector(reviewsButtonDidTap))
        return button
    }()
    
    private let chatButton: SideMenuButton = {
        let button = SideMenuButton()
        button.setupButton(title: "ЧАТ", target: self, action: #selector(chatButtonDidTap))
        return button
    }()
    
    private let articlesButton: SideMenuButton = {
        let button = SideMenuButton()
        button.setupButton(title: "СТАТЬИ", target: self, action: #selector(articlesButtonDidTap))
        return button
    }()
    
    private let helpButton: SideMenuButton = {
        let button = SideMenuButton()
        button.setupButton(title: "ПОМОЩЬ", target: self, action: #selector(helpButtonDidTap))
        return button
    }()
    
    private let barcodeButton: SideMenuButton = {
        let button = SideMenuButton()
        button.setupButton(title: "ШТРИХ-КОД", target: self, action: #selector(barcodeButtonDidTap))
        return button
    }()
    
    private let freeDiagnosticsButton: SideMenuButton = {
        let button = SideMenuButton()
        button.setupButton(title: "БЕСПЛАТНАЯ ДИАГНОСТИКА", target: self, action: #selector(freeDiagnosticsButtonDidTap))
        return button
    }()
    
    private let locationButton: RouteButton = {
        let button = RouteButton()
        button.setupButton(target: self, action: #selector(locationButtonDidTap))
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(closeButton)
        view.addSubview(logoImageView)
        view.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(personalAreaButton)
        verticalStackView.addArrangedSubview(singInButton)
        verticalStackView.addArrangedSubview(techCentersButton)
        verticalStackView.addArrangedSubview(promoButton)
        verticalStackView.addArrangedSubview(reminderButton)
        
        
        
        verticalStackView.addArrangedSubview(reviewsButton)
        verticalStackView.addArrangedSubview(chatButton)
        verticalStackView.addArrangedSubview(articlesButton)
        verticalStackView.addArrangedSubview(helpButton)
        verticalStackView.addArrangedSubview(barcodeButton)
        verticalStackView.addArrangedSubview(freeDiagnosticsButton)
        
        view.addSubview(locationButton)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(20)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 150, height: 63))
            make.top.equalTo(closeButton.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
            make.top.lessThanOrEqualTo(logoImageView.snp.bottom).offset(30)
            make.bottom.lessThanOrEqualTo(locationButton.snp.top)
        }
        
        locationButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(130)
        }
        
    }
    
    // MARK: - Private actions
    
    @objc private func closeButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc private func personalAreaButtonDidTap() {
        print("personalAreaButtonDidTap")
        dismiss(animated: true)
        router?.pushPersonalAreaVC()
        
    }
    
    @objc private func singInButtonDidTap() {
        print("singInButtonDidTap")
    }
    
    @objc private func techCentersButtonDidTap() {
        print("techCentersButtonDidTap")
    }
    
    @objc private func promoButtonDidTap() {
        print("promoButtonDidTap")
    }
    
    @objc private func reminderButtonDidTap() {
        print("reminderButtonDidTap")
    }
    
    @objc private func reviewsButtonDidTap() {
        print("reviewsButtonDidTap")
    }
    
    @objc private func chatButtonDidTap() {
        print("chatButtonDidTap")
    }
    
    @objc private func articlesButtonDidTap() {
        print("articlesButtonDidTap")
    }
    
    @objc private func helpButtonDidTap() {
        print("helpButtonDidTap")
    }
    
    @objc private func barcodeButtonDidTap() {
        print("barcodeButtonDidTap")
    }
    
    @objc private func freeDiagnosticsButtonDidTap() {
        print("freeDiagnosticsButtonDidTap")
    }
    
    @objc private func locationButtonDidTap() {
        print("locationButtonDidTap")
    }
    
}
