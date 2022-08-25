//
//  BonusAPI.swift
//  QMotors
//
//  Created by Mavlon on 25/08/22.
//

import Foundation
import Alamofire
import SwiftyJSON

final class BonusAPI {
    static func bonusList(success: @escaping (BonusResponse) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .bonus, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var bonuses = [Bonus]()
                for bonus in jsonData["result"]["bonuses"].arrayValue {
                    bonuses.append(Bonus(id: bonus["id"].intValue,
                                         bonus_type: bonus["bonus_type"].intValue,
                                         status: bonus["status"].intValue,
                                         points: bonus["points"].intValue,
                                         title: bonus["title"].stringValue,
                                         remainder: bonus["remainder"].intValue,
                                         user_id: bonus["user_id"].intValue,
                                         created_at: bonus["created_at"].stringValue,
                                         updated_at: bonus["created_at"].stringValue))
                }
                let balance: String = jsonData["balance"].stringValue
                let response = BonusResponse(bonuses: bonuses, balance: balance, error: nil)
                success(response)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
}

