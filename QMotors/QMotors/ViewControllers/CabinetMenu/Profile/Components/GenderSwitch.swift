//
//  GenderSwitch.swift
//  QMotors
//
//  Created by MIrmuxammad on 15/08/22.
//

import Foundation
import UIKit

class GenderSwitch: UIView {
    
    
    private let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let mainElipce: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 14
        return view
    }()
    
    let smallElipce: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#9CC55A")
        view.layer.cornerRadius = 8
        return view
    }()
    
    let genderText: UILabel = {
        let label = UILabel()
        label.text = "мужской"
        label.font = UIFont(name: Const.fontMed, size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let button: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.isEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
        
    private func setupViews() {
        addSubview(contentView)
        contentView.addSubview(mainElipce)
        contentView.addSubview(genderText)
        mainElipce.addSubview(smallElipce)
        addSubview(button)
    }
    
    private func setupConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 130, height: 30))
        }
        
        mainElipce.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(1)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
        
        smallElipce.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.center.equalToSuperview()
        }
        
        genderText.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(mainElipce.snp.right).offset(20)
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Public Func
    
    func setupAction(target: Any, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
}
