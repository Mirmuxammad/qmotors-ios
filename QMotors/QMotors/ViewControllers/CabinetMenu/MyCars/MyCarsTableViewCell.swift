//
//  MyCarsTableViewCell.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 23.07.22.
//

import UIKit
import SnapKit
import SDWebImage

class MyCarsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MyCarsTableViewCell"
    
    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#F8F8F8")
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "empty-photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let carNumberView: CarInfoNumberView = {
        let view = CarInfoNumberView()
        return view
    }()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "СУБАРУ"
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .red
        label.textAlignment = .left
        label.text = "УДАЛЕН"
        return label
    }()
    
    private let mileageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Пробег:"
        return label
    }()
    
    private let mileageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "500 600 км"
        return label
    }()
    
    private let lastVisitTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Последний визит:"
        return label
    }()
    
    private let lastVisitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "25.09.2016"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        carImageView.image = UIImage(named: "empty-photo")
    }
    
    // MARK: - Public functions
    
    func setupCell(_ with: MyCarModel) {
        selectionStyle = .none
        setupViews()
        setupConstraints()
        
        if let carPhotos = with.user_car_photos {
            let photoUrl = BaseAPI.baseURL + (carPhotos.first?.photo ?? "")
                print(photoUrl)
                carImageView.sd_setImage(with: URL(string: photoUrl), placeholderImage: nil)
        }
        modelLabel.text = with.model
        mileageLabel.text = with.mileage
        
        if with.last_visit == "" {
            lastVisitLabel.text = "Визита не было"
        } else if let lastVisit = with.last_visit, lastVisit != "" {
            lastVisitLabel.text = lastVisit.getFormattedDate()
        }
        
        if let inMillage = Int(with.mileage) {
            mileageLabel.text = "\(inMillage.formattedWithSeparator) км"
        }
        carNumberView.numberTitle.text = with.number.getCarNumber()
        carNumberView.regionNumber.text = with.number.getCarRegionNumber()
        
        switch with.status {
        case 0:
            statusLabel.isHidden = true
        case 1:
            statusLabel.text = "ПРОДАН"
            statusLabel.isHidden = false
            statusLabel.textColor = UIColor.init(hex: "#9CC55A")
        case 2:
            statusLabel.text = "УДАЛЕН"
            statusLabel.isHidden = false
            statusLabel.textColor = .red

        default:
            statusLabel.isHidden = true
        }
//        if with.status == 0 {
//            statusLabel.isHidden = true
//        } else if with.status == 1 {
//            statusLabel.text = "ПРОДАН"
//            statusLabel.textColor = UIColor.init(hex: "#9CC55A")
//        } else if with.status == 2 {
//            statusLabel.text = "УДАЛЕН"
//            statusLabel.textColor = .red
//        }
    }
    
}

// MARK: - Setup View

extension MyCarsTableViewCell {
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(carImageView)
        carImageView.addSubview(carNumberView)
        
        containerView.addSubview(modelLabel)
        containerView.addSubview(statusLabel)
        containerView.addSubview(mileageTitleLabel)
        containerView.addSubview(mileageLabel)
        containerView.addSubview(lastVisitTitleLabel)
        containerView.addSubview(lastVisitLabel)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        carImageView.snp.makeConstraints { make in
            make.height.width.equalTo(110)
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        carNumberView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalTo(carImageView.snp.centerX)
        }
        
        modelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(carImageView.snp.right).offset(20)
            make.height.equalTo(14)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(carImageView.snp.bottom).offset(2)
            make.height.equalTo(14)
            make.centerX.equalTo(carImageView)
        }
        
        mileageTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(carImageView.snp.right).offset(20)
            make.top.equalTo(modelLabel.snp.bottom).offset(15)
        }
        
        mileageLabel.snp.makeConstraints { make in
            make.left.equalTo(carImageView.snp.right).offset(20)
            make.top.equalTo(mileageTitleLabel.snp.bottom)
        }
        
        
        lastVisitTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(carImageView.snp.right).offset(20)
            make.bottom.equalTo(lastVisitLabel.snp.top)
        }
        
        lastVisitLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalTo(carImageView.snp.right).offset(20)
        }
        
    }
}
