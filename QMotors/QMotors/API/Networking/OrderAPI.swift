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
    
    static func addDiagnosticOrder(carId: Int, carNumber: String, techCenterId: Int, orderTypeId: Int, description: String, lastVisit: Date, freeDiagnostics: Bool, guarantee: Bool, success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let lastVisitStr = formatter.string(from: lastVisit)
        
        let params: Parameters = [
            "order_type_id": orderTypeId,
            "tech_center_id": techCenterId,
            "description": description,
            "date": lastVisitStr,
            "guarantee": guarantee,
            "free_diagnstics": freeDiagnostics,
            "user_car_id": carId,
            "number": carNumber
        ]
        
        BaseAPI.authorizedPostRequest(reqMethod: .order, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                success(jsonData["result"])
                print("запрос ушел")
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
    
    static func orderList(userCarId: Int, success: @escaping (CarOrderResponce) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .orderList(userCarId), parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                let decoder = JSONDecoder()
                
                do {
                    let decod = try decoder.decode(CarOrderResponce.self, from: data)
                    success(decod)
                } catch let error {
                    print(error.localizedDescription)
                }
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
}
