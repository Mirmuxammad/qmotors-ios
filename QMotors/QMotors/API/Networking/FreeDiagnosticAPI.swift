//
//  FreeDiagnosticAPI.swift
//  QMotors
//
//  Created by Руслан Штыбаев on 06.09.2022.
//

import Foundation
import Alamofire

final class FreeDiagnosticAPI {
    static func freeDiagnosticList(success: @escaping (FreeDiagnosticResponce) -> Void, failure: @escaping escapeNetworkError) {
        
        let parameters: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .freeDiagnosticList, parameters: parameters) { data in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let result = try? decoder.decode(FreeDiagnosticResponce.self, from: data)
            guard let diagnostics = result else { return }
            success(diagnostics)
        } failure: { error in
            failure(error)
        }

    }
}
