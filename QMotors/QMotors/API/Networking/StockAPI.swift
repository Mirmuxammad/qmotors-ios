//
//  StockAPI.swift
//  QMotors
//
//  Created by MIrmuxammad on 06/09/22.
//

import Foundation
import Alamofire
import SwiftyJSON

final class StockAPI {
    static func stockList(success: @escaping ([Stock]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .stockList, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var stocks = [Stock]()
                for stock in jsonData["result"].arrayValue {
                    stocks.append(Stock(id: stock["id"].intValue,
                                        title: stock["title"].stringValue,
                                        subtitle: stock["subtitle"].stringValue,
                                        location: stock["location"].string,
                                        description: stock["description"].stringValue,
                                        created_at: stock["created_at"].stringValue,
                                        updated_at: stock["updated_at"].stringValue))
                }
                success(stocks)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func stockDetails(stockId: Int, success: @escaping(StockResponse) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]

        BaseAPI.authorizedGetRequest(reqMethod: .stockDetails(stockId), parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode(StockResponse.self, from: data)
                    success(result)
                } catch {
                    print(error)
                }
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
}


