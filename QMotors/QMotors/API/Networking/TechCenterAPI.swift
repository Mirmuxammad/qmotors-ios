//
//  TechCenterAPI.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 3.08.22.
//

import Foundation
import Alamofire
import SwiftyJSON

final class TechCenterAPI {
    static func techCenterList(success: @escaping ([TechnicalCenter]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.getTechCenterList(reqMethod: .getTechCenterList, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var techCenters = [TechnicalCenter]()
                for techCenter in jsonData["result"].arrayValue {
                    techCenters.append(TechnicalCenter(id: techCenter["id"].intValue,
                                                       title: techCenter["title"].stringValue,
                                                       address: techCenter["address"].stringValue,
                                                       phone: techCenter["phone"].stringValue,
                                                       latitude: techCenter["lat"].stringValue,
                                                       longitude: techCenter["lng"].stringValue))
                }
                print(techCenters)
                success(techCenters)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
}

/*
 var carMarks: [CarMark] = []
 for carMark in jsonData["result"].arrayValue {
 carMarks.append(CarMark(id: carMark["id"].intValue, name: carMark["name"].stringValue))
 }
 success(carMarks)
 */
