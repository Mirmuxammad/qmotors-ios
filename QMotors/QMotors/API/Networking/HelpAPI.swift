//
//  Help.swift
//  QMotors
//
//  Created by Руслан Штыбаев on 01.09.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

final class HeplAPI {
    
    static func helpText(success: @escaping (HelpResponse) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .faq, parameters: params) { data in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let result = try? decoder.decode(HelpResponse.self, from: data)
            guard let response = result else { return }
            success(response)
        } failure: { error in
            failure(error)
        }
    }
}
