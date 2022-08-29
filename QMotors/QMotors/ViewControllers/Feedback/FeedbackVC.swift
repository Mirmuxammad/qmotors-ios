//
//  FeedbackVC.swift
//  QMotors
//
//  Created by Mavlon on 29/08/22.
//

import UIKit

class FeedbackVC: BaseVC {

    // MARK: - UI Elements
    
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
        button.setupAction(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Благодаря вам мы становимся лучше"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private let containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 34
        return stackView
    }()
    
    private let createFeedbackIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "create-feedback-icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let allFeedbacksIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "list-icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let appFeedbackIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "app-feedback-icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let createFeedbackButton: UIButton = {
        let button = UIButton()
        button.setTitle("ОСТАВИТЬ ОТЗЫВЫ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Const.fontReg, size: 18)
        return button
    }()
    
    private let allFeedbackButton: UIButton = {
        let button = UIButton()
        button.setTitle("ВСЕ ОТЗЫВЫ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Const.fontReg, size: 18)

        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    private let appFeedbackButton: UIButton = {
        let button = UIButton()
        button.setTitle("ОЦЕНКА ПРИЛОЖЕНИЯ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Const.fontReg, size: 18)
        return button
    }()
    
    private let firstStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 25
        return stackView
    }()
    
    private let secondStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 25
        return stackView
    }()
    
    private let thirdStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 25
        return stackView
    }()
    
    private let myview : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    override func leftMenuButtonDidTap() {
        sideMenuVC.rootScreen = .techCenter
        super.leftMenuButtonDidTap()
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(containerStack)
        firstStack.addArrangedSubview(createFeedbackIcon)
        firstStack.addArrangedSubview(createFeedbackButton)
        secondStack.addArrangedSubview(allFeedbacksIcon)
        secondStack.addArrangedSubview(allFeedbackButton)
        thirdStack.addArrangedSubview(appFeedbackIcon)
        thirdStack.addArrangedSubview(appFeedbackButton)
        containerStack.addArrangedSubview(firstStack)
        containerStack.addArrangedSubview(secondStack)
        containerStack.addArrangedSubview(thirdStack)
    }
    
    private func setupConstraints() {
        
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
            make.height.equalTo(54)
        }
        
        createFeedbackIcon.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        allFeedbacksIcon.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        appFeedbackIcon.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        containerStack.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(36)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }

}
