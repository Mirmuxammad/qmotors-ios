//
//  APINetworkLogger.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 19.07.22.
//

import Foundation
import Alamofire

class APINetworkLogger: EventMonitor {
//    let queue = DispatchQueue(label: "com.raywenderlich.gitonfire.networklogger")
    
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else {
            return
        }
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            print(json)
        }
    }
}
