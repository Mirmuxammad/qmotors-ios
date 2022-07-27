//
//  CarAPI.swift
//  QMotors
//
//  Created by Akhrorkhuja on 27/07/22.
//

import Foundation
import SwiftyJSON
import Alamofire

final class CarAPI {
    static func carMarkList(success: @escaping ([CarMark]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .carMarkList, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var carMarks: [CarMark] = []
                for carMark in jsonData["result"].arrayValue {
                    carMarks.append(CarMark(id: carMark["id"].intValue, name: carMark["name"].stringValue))
                }
                success(carMarks)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func carModelList(success: @escaping ([CarModel]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .carModelList, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var carModels: [CarModel] = []
                for carModel in jsonData["result"].arrayValue {
                    carModels.append(CarModel(id: carModel["id"].intValue, name: carModel["name"].stringValue))
                }
                success(carModels)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func carModelListByMarkId(markId: Int, success: @escaping ([CarModel]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [
            "car_mark_id": markId
        ]
        
        BaseAPI.authorizedGetRequest(reqMethod: .carModelList, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var carModels: [CarModel] = []
                for carModel in jsonData["result"].arrayValue {
                    carModels.append(CarModel(id: carModel["id"].intValue, name: carModel["name"].stringValue))
                }
                success(carModels)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
}
