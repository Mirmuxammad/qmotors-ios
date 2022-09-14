//
//  HelpController.swift
//  QMotors
//
//  Created by Руслан Штыбаев on 01.09.2022.
//

import Foundation
import UIKit

class HelpVC: BaseVC {
    
    var helpReq = ""
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "small_logo")
        return imageView
    }()
    
    private let backgroundView: UIView = UIView()
    
    private let scrollView: UIScrollView = UIScrollView()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Помощь"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.font = UIFont(name: "Montserrat", size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let backButton: SmallBackButton = {
        let button = SmallBackButton()
        button.setupAction(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        backgroundView.backgroundColor = .white
        
        loadHelp()
    }
    
    override func leftMenuButtonDidTap() {
        sideMenuVC.rootScreen = .FAQ
        super.leftMenuButtonDidTap()
    }

    private func loadHelp() {
        activityIndicator.startAnimating()
        HeplAPI.helpText { [weak self] heplRequest in
            print("1")
            guard let self = self else { return }
            print("2")
            guard let request = heplRequest.result?.text else { return }
            print("hello")
            self.helpReq = request
            self.label.text = self.helpReq.htmlToString
            self.activityIndicator.stopAnimating()
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self.activityIndicator.stopAnimating()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    private func setupView() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(label)
        view.addSubview(activityIndicator)
        
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
            make.top.equalToSuperview().offset(20)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.height.equalTo(22)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLable).offset(40)
            make.right.equalToSuperview().offset(-25)
            make.left.equalToSuperview().offset(25)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        
        let weight = self.backgroundView.frame.width
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(25)
            make.bottom.right.equalToSuperview().offset(-25)
            make.width.equalTo(weight - 40)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
