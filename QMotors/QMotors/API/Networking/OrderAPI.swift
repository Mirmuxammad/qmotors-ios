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
    
    static func addDiagnosticOrderWithStock(carId: String, carNumber: String, techCenterId: Int, orderTypeId: Int, description: String, mileage: Int, dateVisit: String, freeDiagnostics: Bool, guarantee: Bool, stockID: Int, success: @escaping (OrderResponse) -> Void, failure: @escaping escapeNetworkError) {
        
        let params: Parameters = [
            "order_type_id": orderTypeId,
            "tech_center_id": techCenterId,
            "description": description,
            "mileage": mileage,
            "date": dateVisit,
            "guarantee": guarantee,
            "free_diagnstics": freeDiagnostics,
            "user_car_id": carId,
            "number": carNumber,
            "stock_id": stockID
        ]
        
        BaseAPI.authorizedPostRequest(reqMethod: .order, parameters: params, success: { data in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let result = try? decoder.decode(OrderResponse.self, from: data)
            guard let response = result else { return }
                success(response)
        }) { error in
            failure(error)
        }
    }
    
    static func addDiagnosticOrder(carId: String, carNumber: String, techCenterId: Int, orderTypeId: Int, description: String, mileage: Int, dateVisit: String, freeDiagnostics: Bool, guarantee: Bool, success: @escaping (OrderResponse) -> Void, failure: @escaping escapeNetworkError) {
        
        let params: Parameters = [
            "order_type_id": orderTypeId,
            "tech_center_id": techCenterId,
            "description": description,
            "mileage": mileage,
            "date": dateVisit,
            "guarantee": guarantee,
            "free_diagnstics": freeDiagnostics,
            "user_car_id": carId,
            "number": carNumber
        ]
        
        BaseAPI.authorizedPostRequest(reqMethod: .order, parameters: params, success: { data in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let result = try? decoder.decode(OrderResponse.self, from: data)
            guard let response = result else { return }
                success(response)
        }) { error in
            failure(error)
        }
    }
    
    static func addPhotoToOrder(orderId: Int, fileURLArray: [URL], success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError) {
        BaseAPI.authorizedMultipartPostRequestForOrder(orderId: orderId, fieldName: "photo", fileURLArray: fileURLArray, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                print("Photo goes")
                success(jsonData["result"])
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func addPhotoToOrder(orderId: Int, dataArray: [Data], success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError) {
        BaseAPI.authorizedMultipartPostRequestForOrder(orderId: orderId, fieldName: "photo", dataArray: dataArray, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                print("Photo goes")
                success(jsonData["result"])
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
