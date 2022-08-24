//
//  ReminderCellEditButton.swift
//  QMotors
//
//  Created by MIrmuxammad on 24/08/22.
//

import UIKit
import SnapKit

class ReminderCellEditButton: UIView {

    // MARK: - UI Elements
    
    private let titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "edit_icon")
        return imageView
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
        addSubview(button)
    }
    
    private func setupConstraints() {
        
        titleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
    
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Public function
    
    func setupAction(target: Any, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }

}
