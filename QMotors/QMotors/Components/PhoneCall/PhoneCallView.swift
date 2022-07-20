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
    
    private let tagankaButton: PhoneCallButton = {
        let button = PhoneCallButton()
        button.setupButton(title: "АТЦ \"ТАГАНКА\"", target: self, action: #selector(tagankaButtonDidTap))
        return button
    }()
    
    private let mitinoButton: PhoneCallButton = {
        let button = PhoneCallButton()
        button.setupButton(title: "АТЦ \"МИТИНО\"", target: self, action: #selector(mitinoButtonDidTap))
        return button
    }()
    
    private let butovoButton: PhoneCallButton = {
        let button = PhoneCallButton()
        button.setupButton(title: "АТЦ \"БУТОВО\"", target: self, action: #selector(butovoButtonDidTap))
        return button
    }()
    
    private let medvezhkovoButton: PhoneCallButton = {
        let button = PhoneCallButton()
        button.setupButton(title: "АТЦ \"МЕДВЕЖКОВО\"", target: self, action: #selector(medvezhkovoButtonDidTap))
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
        addSubview(tagankaButton)
        addSubview(mitinoButton)
        addSubview(butovoButton)
        addSubview(medvezhkovoButton)
        addSubview(requestCallButton)
    }
    
    private func setupConstraints() {
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tagankaButton.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
        mitinoButton.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.left.right.equalToSuperview()
            make.top.equalTo(tagankaButton.snp.bottom).offset(30)
        }
        
        butovoButton.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.left.right.equalToSuperview()
            make.top.equalTo(mitinoButton.snp.bottom).offset(30)
        }
        
        medvezhkovoButton.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.left.right.equalToSuperview()
            make.top.equalTo(butovoButton.snp.bottom).offset(30)
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
    
    @objc private func tagankaButtonDidTap() {
        print("tagankaButtonDidTap")
        callNumber(phoneNumber: "+74951507073")
    }
    
    @objc private func mitinoButtonDidTap() {
        print("mitinoButtonDidTap")
        callNumber(phoneNumber: "+74951507721")
    }
    
    @objc private func butovoButtonDidTap() {
        print("butovoButtonDidTap")
        callNumber(phoneNumber: "+74953745055")
    }
    
    @objc private func medvezhkovoButtonDidTap() {
        print("medvezhkovoButtonDidTap")
        callNumber(phoneNumber: "+74951507036")
    }
    
    @objc private func requestCallButtonDidTap() {
        print("requestCallButtonDidTap")
    }
        
}
