//
//  ChatVideoPreview.swift
//  QMotors
//
//  Created by Mavlon on 21/09/22.
//

import UIKit

class ChatVideoPreview: UIView {

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let chatImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let playImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "play")
        view.tintColor = .white
        return view
    }()
    
    private let openImageButton: UIButton = {
        let button = UIButton()
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupConstraints()
    }
    
    func configureView(target: Any, selector: Selector) {
        openImageButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    private func setupViews() {
        self.clipsToBounds = true
        addSubview(lineView)
        addSubview(chatImageView)
        addSubview(playImageView)
        addSubview(openImageButton)
    }
    
    private func setupConstraints() {
        
        lineView.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.left.top.bottom.equalToSuperview()
        }
        
        chatImageView.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right)
            make.right.top.bottom.equalToSuperview()
        }
        
        openImageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        playImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
}
