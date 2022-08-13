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
        
        BaseAPI.authorizedGetRequest(reqMethod: .getTechCenterList, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var techCenters = [TechnicalCenter]()
                var userDefTechCenters = [String]()
                for techCenter in jsonData["result"].arrayValue {
                    techCenters.append(TechnicalCenter(id: techCenter["id"].intValue,
                                                       title: techCenter["title"].stringValue,
                                                       address: techCenter["address"].stringValue,
                                                       phone: techCenter["phone"].stringValue,
                                                       latitude: techCenter["lat"].stringValue,
                                                       longitude: techCenter["lng"].stringValue))
                    userDefTechCenters.append(techCenter["title"].stringValue)
                }
                UserDefaultsService.sharedInstance.centras = userDefTechCenters
                success(techCenters)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
}

