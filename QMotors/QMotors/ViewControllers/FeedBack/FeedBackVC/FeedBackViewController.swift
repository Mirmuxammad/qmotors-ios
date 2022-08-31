//
//  FeedBackViewController.swift
//  QMotors
//
//  Created by Александр Гужавин on 26.08.2022.
//

import UIKit
import SnapKit
import StoreKit

class FeedBackViewController: BaseVC {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "small_logo")
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let backButton: SmallBackButton = {
        let button = SmallBackButton()
        return button
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Благодаря вам мы страновимся лучше"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let createFeedBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("   Оставить отзыв", for: .normal)
        button.tintColor = .black
        button.imageView?.tintColor = .black
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        button.setImage(UIImage(named: "old_pen"), for: .normal)
        return button
    }()
    
    private let allFeedBacksButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("   Все отзывы", for: .normal)
        button.tintColor = .black
        button.imageView?.tintColor = .black
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        button.setImage(UIImage(named: "listNumber"), for: .normal)
        return button
    }()
    
    private let rateAppButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("   Оценка приложения", for: .normal)
        button.tintColor = .black
        button.imageView?.tintColor = .black
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        button.setImage(UIImage(named: "like"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
        backButton.setupAction(target: self, action: #selector(backButtonDidTap))
        createFeedBackButton.addTarget(self, action: #selector(openCreateFeedBack), for: .touchUpInside)
        allFeedBacksButton.addTarget(self, action: #selector(openAllFeedBacks), for: .touchUpInside)
        rateAppButton.addTarget(self, action: #selector(openRateApp), for: .touchUpInside)
    }
    
    override func leftMenuButtonDidTap() {
        sideMenuVC.rootScreen = .feedBack
        super.leftMenuButtonDidTap()
    }
    

}

// MARK: - Private actions
extension FeedBackViewController {
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func openCreateFeedBack() {
        router?.pushCreateFeedBackVC()
    }
    
    @objc private func openAllFeedBacks() {
        router?.pushAllFeedBAcks()
    }
    
    @objc private func openRateApp() {
        print("открыть приложение в сторе")
        rateApp()
    }
    
    private func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "https://apps.apple.com/ru/app/quality-motors/id1600050001") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
}

// MARK: - Setup Views
extension FeedBackViewController {
    
    private func addViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(createFeedBackButton)
        backgroundView.addSubview(allFeedBacksButton)
        backgroundView.addSubview(rateAppButton)
    }
    
    private func addConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 55, height: 55))
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 23))
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(40)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(backButton.snp.bottom).offset(20)
        }
        
        createFeedBackButton.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(40)
            make.left.equalTo(titleLable.snp.left)
        }
        
        allFeedBacksButton.snp.makeConstraints { make in
            make.top.equalTo(createFeedBackButton.snp.bottom).offset(34)
            make.left.equalTo(titleLable.snp.left)
        }
        
        rateAppButton.snp.makeConstraints { make in
            make.top.equalTo(allFeedBacksButton.snp.bottom).offset(34)
            make.left.equalTo(titleLable.snp.left)
        }
    }
    
    
}
