//
//  MyCarsTableViewCell.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 23.07.22.
//

import UIKit
import SnapKit

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
        imageView.image = UIImage(named: "subaru")
        return imageView
    }()
    
//    private let carNumberImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "car_number")
//        return imageView
//    }()
    
    private let carNumberView = CarNumberView()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "СУБАРУ"
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
        
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(carImageView)
        carImageView.addSubview(carNumberView)
        
        containerView.addSubview(modelLabel)
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
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        modelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(carImageView.snp.right).offset(20)
            make.height.equalTo(14)
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
    
    // MARK: - Public functions
    
    func setupCell(_ with: MyCarModel) {
        modelLabel.text = with.model
        mileageLabel.text = with.mileage
        lastVisitLabel.text = with.last_visit.getFormattedDate()
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    
    
}
