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
        return lable
    }()
    
    private let centerNameLable: UILabel = {
        let lable = UILabel()
         lable.font = UIFont(name: "Montserrat-Regular", size: 14)
         lable.text = "Тех.центр “Центр”"
         return lable
     }()
    
    private let mileageLable: UILabel = {
        let lable = UILabel()
         lable.font = UIFont(name: "Montserrat-Regular", size: 14)
         lable.text = "пробег: 000 000 км."
         return lable
     }()
    
    func setTitles(order: Order) {
        setViews()
        numberOrderLable.text = order.order_number + " от " + order.created_at.getFormattedDate()
        let centerId = order.tech_center_id
        let centerName = UserDefaultsService.sharedInstance.centras?[centerId - 1] ?? "Центр"
        centerNameLable.text = "Тех.центр “\(centerName)”"
        mileageLable.text = "пробег: \(order.mileage ?? "000") км."
    }
    
    func setupTitlesForEmptyOrder() {
        setViews()
        numberOrderLable.text = "Нет истории посещения"
        centerNameLable.text = ""
        mileageLable.text = ""
    }
    
    private func setViews() {
        backgroundColor = UIColor.init(hex: "#F8F8F8")
        addSubview(numberOrderLable)
        addSubview(centerNameLable)
        addSubview(mileageLable)
        
        numberOrderLable.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(24)
        }
        
        centerNameLable.snp.makeConstraints { make in
            make.left.equalTo(numberOrderLable.snp.left)
            make.top.equalTo(numberOrderLable.snp.bottom).offset(12)
        }
        
        mileageLable.snp.makeConstraints { make in
            make.left.equalTo(numberOrderLable.snp.left)
            make.top.equalTo(centerNameLable.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
}
