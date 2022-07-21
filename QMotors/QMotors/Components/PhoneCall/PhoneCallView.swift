//
//  PhoneCallView.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 15.07.22.
//

import UIKit
import SnapKit

class PhoneCallView: UIView {

    // MARK: - UI Elements
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "view_with_triange")
        return imageView
    }()
    
    private let michurinskyButton: PhoneCallButton = {
        let button = PhoneCallButton()
        button.setupButton(title: "АТЦ \"МИЧУРИНСКИЙ\"", target: self, action: #selector(michurinskyButtonDidTap))
        return button
    }()
    
    private let sevastopolButton: PhoneCallButton = {
        let button = PhoneCallButton()
        button.setupButton(title: "АТЦ \"СЕВАСТОПОЛЬСКИЙ\"", target: self, action: #selector(sevastopolButtonDidTap))
        return button
    }()
    
    private let dmitrovkaButton: PhoneCallButton = {
        let button = PhoneCallButton()
        button.setupButton(title: "АТЦ \"ДМИТРОВКА\"", target: self, action: #selector(dmitrovkaButtonDidTap))
        return button
    }()
    
    private let kalugaButton: PhoneCallButton = {
        let button = PhoneCallButton()
        button.setupButton(title: "АТЦ \"КАЛУЖСКАЯ\"", target: self, action: #selector(kalugaButtonDidTap))
        return button
    }()
    
    
    private let requestCallButton: RequestCallButton = {
        let button = RequestCallButton()
        button.setupButton(target: self, action: #selector(requestCallButtonDidTap))
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
        addSubview(michurinskyButton)
        addSubview(sevastopolButton)
        addSubview(dmitrovkaButton)
        addSubview(kalugaButton)
        addSubview(requestCallButton)
    }
    
    private func setupConstraints() {
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        michurinskyButton.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
        sevastopolButton.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.left.right.equalToSuperview()
            make.top.equalTo(michurinskyButton.snp.bottom).offset(30)
        }
        
        dmitrovkaButton.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.left.right.equalToSuperview()
            make.top.equalTo(sevastopolButton.snp.bottom).offset(30)
        }
        
        kalugaButton.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.left.right.equalToSuperview()
            make.top.equalTo(dmitrovkaButton.snp.bottom).offset(30)
        }
        
        requestCallButton.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }

    }
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // MARK: - Private actions
    
    @objc private func michurinskyButtonDidTap() {
        print("michurinskyButtonDidTap")
        callNumber(phoneNumber: "+74951507721")
    }
    
    @objc private func sevastopolButtonDidTap() {
        print("sevastopolButtonDidTap")
        callNumber(phoneNumber: "+74951507036")
    }
    
    @objc private func dmitrovkaButtonDidTap() {
        print("dmitrovkaButtonDidTap")
        callNumber(phoneNumber: "+74951507073")
    }
    
    @objc private func kalugaButtonDidTap() {
        print("kalugaButtonDidTap")
        callNumber(phoneNumber: "+74953745055")
    }
    
    @objc private func requestCallButtonDidTap() {
        print("requestCallButtonDidTap")
    }
        
}
