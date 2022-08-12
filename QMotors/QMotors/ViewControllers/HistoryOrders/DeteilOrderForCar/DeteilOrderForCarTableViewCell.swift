//
//  DeteilOrderForCarTableViewCell.swift
//  QMotors
//
//  Created by Александр Гужавин on 11.08.2022.
//

import UIKit
import SnapKit

class DeteilOrderForCarTableViewCell: UITableViewCell {
    
    static let identifier = "DeteilOrderForCarCell"
    
    private let data = ["", "Работа:", "Запчасти:", "Рекомендации:", "Пробег:"]

    let title: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Montserrat-Medium", size: 14)
        lable.text = "Go"
        return lable
    }()
    
    let subTitle: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Montserrat-Regular", size: 14)
        lable.text = "Go"
        return lable
    }()
    
    func setTitle(row: Int, title: String?, subTitle: String?) {
        if row == 0 {
            self.title.font = UIFont(name: "Montserrat-SemiBold", size: 14)
            
        }
    }
    
    private func setViews(row: Int) {
        backgroundColor = UIColor.init(hex: "#F8F8F8")
        if row == 0 {
            addSubview(title)
            
            title.snp.makeConstraints { make in
                make.top.left.equalToSuperview().offset(24)
                make.bottom.equalToSuperview().offset(-24)
            }
        } else {
            addSubview(title)
            addSubview(subTitle)
            
            title.snp.makeConstraints { make in
                make.top.left.equalToSuperview().offset(24)
            }
            
            subTitle.snp.makeConstraints { make in
                make.left.equalTo(title.snp.left)
                make.top.equalTo(title.snp.bottom).offset(12)
                make.bottom.equalToSuperview().offset(-24)
            }
        }
    }

}
