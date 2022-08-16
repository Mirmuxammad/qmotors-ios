//
//  CustomPhotoView.swift
//  QMotors
//
//  Created by Akhrorkhuja on 27/07/22.
//

import UIKit
import SnapKit

class CustomPhotoView: UIView {

    // MARK: - Properties
    var photo: UIImage = UIImage(named: "empty-photo")! {
        didSet {
            imageView.image = photo
            if photo == UIImage(named: "empty-photo") {
                self.layer.borderWidth = 1
                photoButton.isEnabled = true
                removePhotoButton.isHidden = true
            } else {
                self.layer.borderWidth = 0
                photoButton.isEnabled = false
                removePhotoButton.isHidden = false
            }
        }
    }
    
    // MARK: - UI Elements
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    let photoButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let removePhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "trash-icon"), for: .normal)
        button.tintColor = .clear
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.backgroundColor = UIColor(hex: "EF4646")
        button.layer.cornerRadius = 4
        button.isHidden = true
        return button
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Setup View
extension CustomPhotoView {
    private func setupView() {
        imageView.image = photo
        
        self.backgroundColor = UIColor(hex: "F8F8F8")
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hex: "B1B1B1").cgColor
        self.layer.cornerRadius = 4
        
        self.addSubview(imageView)
        self.addSubview(photoButton)
        self.addSubview(removePhotoButton)
        
        
        
        setupConstraints()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        photoButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        removePhotoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.width.height.equalTo(24)
        }
    }
}

// MARK: - Methods
extension CustomPhotoView {
    
}
