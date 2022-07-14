//
//  RouteButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 14.07.22.
//

import UIKit
import SnapKit

class RouteButton: UIView {
    
    // MARK: - UI Elements
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#B6B6B6")
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location_logo")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "ПОСТРОИТЬ МАРШРУТ \nДО СЕРВИСА"
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    // MARK: - Initializers
    
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
        addSubview(backgroundImageView)
        addSubview(topLineView)
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(button)
    }
    
    private func setupConstraints() {
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topLineView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(17)
            make.right.equalToSuperview().offset(-17)
            make.height.equalTo(1)
        }
    
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 23, height: 23))
            make.top.equalTo(topLineView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(17)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalTo(logoImageView.snp.left)
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Public function
    
    func setupButton(target: Any, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
}
