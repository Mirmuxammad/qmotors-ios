//
//  CarInfoCollectionViewCell.swift
//  QMotors
//
//  Created by Akhrorkhuja on 14/08/22.
//

import UIKit
import SDWebImage
import SnapKit

class CarInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "carInfoCollectionCell"
    
    // MARK: - Properties
    var sliderImage: URL? {
        didSet {
            sliderImageView.sd_setImage(with: sliderImage, placeholderImage: nil)
            sliderImageView.contentMode = .scaleAspectFill
        }
    }
    
    var carNumberTitle: String? {
        didSet {
            guard let carNumberTitle = carNumberTitle else { return }
            carNumberView.numberTitle.text = carNumberTitle
        }
    }
    
    var carNumberRegion: String? {
        didSet {
            guard let carNumberRegion = carNumberRegion else { return }
            carNumberView.regionNumber.text = carNumberRegion
        }
    }
    
    // MARK: - UI Elements
    private let sliderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "empty-photo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let carNumberView: CarInfoNumberView = {
        let view = CarInfoNumberView()
        return view
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(sliderImageView)
        contentView.addSubview(carNumberView)
    }
    
    private func setupConstraints() {
        sliderImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        carNumberView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
}
