//
//  CarModelResponse.swift
//  QMotors
//
//  Created by Akhrorkhuja on 27/07/22.
//

import Foundation

struct CarModelResponse: Codable {
    let result: [CarModel]
    let error: CustomError?
}

struct CarModel: Codable {
    let id: Int
    let name: String
}
