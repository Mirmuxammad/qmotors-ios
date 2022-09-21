//
//  ChatPhotoView.swift
//  QMotors
//
//  Created by Mavlon on 21/09/22.
//

import UIKit
import SDWebImage

class ChatPhotoView: UIView {
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let chatImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
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
    
    func configureView(target: Any, selector: Selector, image: String) {
        openImageButton.addTarget(target, action: selector, for: .touchUpInside)
        chatImageView.sd_setImage(with: URL(string: BaseAPI.baseURL + image))
    }
    
    private func setupViews() {
        self.clipsToBounds = true
        addSubview(lineView)
        addSubview(chatImageView)
        addSubview(openImageButton)
    }
    
    private func setupConstraints() {
        
//        self.snp.makeConstraints { make in
//            make.height.equalTo(150)
//        }
        
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
        
    }
    
}
