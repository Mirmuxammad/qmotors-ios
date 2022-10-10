//
//  OrderForCarTableViewCell.swift
//  QMotors
//
//  Created by Александр Гужавин on 11.08.2022.
//

import UIKit
import SnapKit

class OrderForCarTableViewCell: UITableViewCell {
    
    static let identifier = "OrderForCarCell"
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#F8F8F8")
        return view
    }()

    private let numberOrderLable: UILabel = {
       let lable = UILabel()
        lable.font = UIFont(name: "Montserrat-Bold", size: 14)
        lable.textColor = UIColor.init(hex: "#5A80C0")
        lable.text = "A00000000000000" + " от " + "00.00.0000"
        lable.numberOfLines = 0
        return lable
    }()
    
    private let stockLable: UILabel = {
       let lable = UILabel()
        lable.font = UIFont(name: "Montserrat-Regular", size: 14)
        lable.numberOfLines = 0
        lable.text = "Акция: тест тест тест тест тест тест тест тест тест тест тест тест тест тест"
        return lable
    }()
    
    private let centerNameLable: UILabel = {
        let lable = UILabel()
         lable.font = UIFont(name: "Montserrat-Regular", size: 14)
//         lable.text = "Тех.центр “Центр”"
         return lable
     }()
    
    private let mileageLable: UILabel = {
        let lable = UILabel()
         lable.font = UIFont(name: "Montserrat-Regular", size: 14)
         lable.text = "пробег: не указан"//000 000 км."
         return lable
     }()
        
    func visitHistory(order: Order, car: MyCarModel) {
        setViews()
        
        if let description = order.description {
            numberOrderLable.text = "\(description) на \(order.date.getFormattedDate())"
        } else {
            numberOrderLable.text = "на \(order.date.getFormattedDate())"
        }
        
        let centerId = order.tech_center_id
        let centerName = UserDefaultsService.sharedInstance.centras?[centerId - 1] ?? ""
        centerNameLable.text = "Автосервис: “\(centerName)”"

        guard let orderMilage = order.mileage else {
            mileageLable.text = "Пробег: \(Int(car.mileage)?.formattedWithSeparator ?? "") км"
            return
        }
        
        if orderMilage == "0" || orderMilage == "00" || orderMilage == "000" {
            mileageLable.text = "Пробег: не указан"
        } else {
            mileageLable.text = "Пробег: \(Int(orderMilage)?.formattedWithSeparator ?? "") км"
        }
        
        if let stockTitle = order.stock?.title {

            stockLable.text = "Акция: \(stockTitle)"

            stockLable.isHidden = false
            
            numberOrderLable.snp.remakeConstraints { make in
                make.top.left.equalToSuperview().offset(24)
                make.right.equalToSuperview().offset(-24)
            }
            
            stockLable.snp.remakeConstraints { make in
                make.left.equalTo(numberOrderLable.snp.left)
                make.right.equalToSuperview().offset(-24)
                make.top.equalTo(numberOrderLable.snp.bottom).offset(12)
            }
            
            centerNameLable.snp.remakeConstraints { make in
                make.left.equalTo(numberOrderLable.snp.left)
                make.right.equalToSuperview().offset(-24)
                make.top.equalTo(stockLable.snp.bottom).offset(12)
            }

            mileageLable.snp.remakeConstraints { make in
                make.left.equalTo(numberOrderLable.snp.left)
                make.top.equalTo(centerNameLable.snp.bottom).offset(12)
                make.bottom.equalToSuperview().offset(-24)
            }
        } else {
            stockLable.isHidden = true
        }
    }
    
    func setupTitlesForEmptyOrder() {
        setViews()
//        numberOrderLable.text = "Нет истории посещения"
//        centerNameLable.text = ""
//        mileageLable.text = ""
    }
    
    private func setViews() {
        self.selectionStyle = .none
        backgroundColor = UIColor.init(hex: "#F8F8F8")
        
        contentView.addSubview(numberOrderLable)
        contentView.addSubview(stockLable)
        contentView.addSubview(centerNameLable)
        contentView.addSubview(mileageLable)
        
        numberOrderLable.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }

        centerNameLable.snp.makeConstraints { make in
            make.left.equalTo(numberOrderLable.snp.left)
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(numberOrderLable.snp.bottom).offset(12)
        }

        mileageLable.snp.makeConstraints { make in
            make.left.equalTo(numberOrderLable.snp.left)
            make.top.equalTo(centerNameLable.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
}
