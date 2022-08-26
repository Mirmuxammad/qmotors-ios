//
//  AllFeedBacksTableViewCell.swift
//  QMotors
//
//  Created by Александр Гужавин on 26.08.2022.
//

import UIKit
import SnapKit

class AllFeedBacksTableViewCell: UITableViewCell {
    
    static let indentity = "AllFeedBacks"
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let nameLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont(name: "Montserrat-Bold", size: 16)
        lable.text = "Фамилия Имя Отчество"
        lable.numberOfLines = 2
        return lable
    }()
    
    private let techCenterLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Montserrat-Regular", size: 16)
        lable.textColor = .black
        lable.text = "Сервис  |  00.00.0000"
        return lable
    }()
    
    private let strasImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stars_test")
        return imageView
    }()
    
    private let commentLable: UILabel = {
        let lable = UILabel()
        lable.textColor = UIColor(red: 0.196, green: 0.196, blue: 0.196, alpha: 1)
        lable.font = UIFont(name: "Montserrat-Regular", size: 14)
        lable.numberOfLines = 0
        lable.textAlignment = .left
        lable.text = "Здесь будут текст отзывы Ибрагима Сардор углы Арипова, он делал диагностику перед покупкой. Насчитали большой ремонт: \nЗамена сцепления\nЗамена жидкостей"
        return lable
    }()


    func config(review: Review, serviceName: String) {
        techCenterLable.text = serviceName + "  |  " + (review.updatedAt.getFormattedDate() )
        commentLable.text = review.comment
        addViews()
    }
    
    
    private func addViews() {
        addSubview(backView)
        backView.addSubview(nameLable)
        backView.addSubview(techCenterLable)
        backView.addSubview(strasImageView)
        backView.addSubview(commentLable)
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        nameLable.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        techCenterLable.snp.makeConstraints { make in
            make.top.equalTo(nameLable.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
        }
        strasImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(techCenterLable.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
        commentLable.snp.makeConstraints { make in
            make.top.equalTo(strasImageView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.bottom.equalToSuperview().offset(-24)
        }
    }
    
}
