//
//  TechCellSingUpButton.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 28.07.22.
//

import UIKit
import SnapKit

class TechCellSingUpButton: UIView {
    
    // MARK: - UI Elements
    
    private let titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "black_pen")
        return imageView
    }()
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Записаться"
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
        
        layer.cornerRadius = 5
        layer.backgroundColor = UIColor.init(hex: "#EBEBEB").cgColor
    
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(titleView)
        titleView.addSubview(logoImageView)
        titleView.addSubview(titleLabel)
        addSubview(button)
    }
    
    private func setupConstraints() {
        
        titleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
            
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.centerX.equalToSuperview().offset(17)
        }
    
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Public function
    
    func setupAction(target: Any, action: Selector, tag: Int) {
        button.tag = tag
        button.addTarget(target, action: action, for: .touchUpInside)
    }

}
