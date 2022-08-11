//
//  OrderAPI.swift
//  QMotors
//
//  Created by Александр Гужавин on 09.08.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

final class OrderAPI {
    static func orderTybeList(success: @escaping ([OrderType]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .orderTypeList, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var ordertypes = [OrderType]()
                for ordertype in jsonData["result"].arrayValue {
                    
                    ordertypes.append(OrderType(id: ordertype["id"].intValue,
                                                name: ordertype["name"].stringValue))
                }
                //print(ordertypes)
                success(ordertypes)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func addNewOrder(order: NewOrder, success: @escaping (String) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = ["user_car_id": order.carId,
                                  "number": order.carNumber,
                                  "order_type_id": order.orderTypeId,
                                  "tech_center_id": order.techCenterId,
                                  "guarantee": order.guarantee,
                                  "date": order.date,
                                  "description": order.description]
        
        BaseAPI.authorizedPostRequest(reqMethod: .order, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                print(jsonData["result"])
                success("ordertypes")
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
}
