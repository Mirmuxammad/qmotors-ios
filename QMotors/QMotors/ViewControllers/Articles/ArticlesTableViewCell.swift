//
//  ArticlesTableViewCell.swift
//  QMotors
//
//  Created by Александр Гужавин on 31.08.2022.
//

import UIKit
import SnapKit
import SDWebImage

class ArticlesTableViewCell: UITableViewCell {
    
    static let identifier = "ArticlesCell"
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
        view.layer.cornerRadius = 5
        return view
    }()

    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "empty-photo")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let topTitle: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        lable.numberOfLines = 1
        lable.textAlignment = .left
        return lable
    }()
    
    private let dateTitle: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Montserrat-Regular", size: 14)
        return lable
    }()
    
    private let deteilTitle: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Montserrat-Regular", size: 14)
        lable.numberOfLines = 3
        return lable
    }()
    
    
    func setView(title: String, date: String, deteil: String, imageURL: URL?) {
        topTitle.text = title
        dateTitle.text = date
        deteilTitle.text = deteil
        
        self.image.sd_setImage(with: imageURL)
        addViews()
    }
    
    
    
    private func addViews() {
        addSubview(backView)
        backView.addSubview(image)
        backView.addSubview(topTitle)
        backView.addSubview(dateTitle)
        backView.addSubview(deteilTitle)
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        image.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)
            make.height.width.equalTo(116)
        }
        
        topTitle.snp.makeConstraints { make in
            make.top.equalTo(image)
            make.left.equalTo(image.snp.right).offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        dateTitle.snp.makeConstraints { make in
            make.top.equalTo(topTitle.snp.bottom).offset(16)
            make.left.equalTo(topTitle)
            make.right.equalTo(topTitle)
        }
        
        deteilTitle.snp.makeConstraints { make in
            make.top.equalTo(dateTitle.snp.bottom).offset(16)
            make.left.equalTo(topTitle)
            make.right.equalTo(topTitle)
        }
    }

}
