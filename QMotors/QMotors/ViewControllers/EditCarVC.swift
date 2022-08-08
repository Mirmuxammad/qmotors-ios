//
//  EditCarVC.swift
//  QMotors
//
//  Created by MIrmuxammad on 08/08/22.
//

import UIKit
import SnapKit

class EditCarVC: BaseVC {
    
    //MARK: -UI Elements-
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Редактировать"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let saveButton: ActionButton = {
        let button = ActionButton()
        button.setupButton(target: self, action: #selector(editButtonDidTap))
        button.setupTitle(title: "Редактировать")
        button.isEnabled()
        return button
    }()
    
    private let trashButton: ActionButton = {
        let button = ActionButton()
        button.setupButton(target: self, action: #selector(trashButtonDidTap))
        button.setupTitle(title: "\(UIImage(named: "trash"))")
        button.isEnabled()
        return button
    }()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Private functions -
    
    
    private func setupView() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(saveButton)
        backgroundView.addSubview(trashButton)
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
        
        
    }
    
    //MARK: -Private Action-
    
    @objc private func backButtonDidTap() {
        router?.back()
    }
    
    @objc private func editButtonDidTap() {
        
    }
    
    @objc private func trashButtonDidTap() {
        
    }
}

