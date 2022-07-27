//
//  CarMarkResponse.swift
//  QMotors
//
//  Created by Akhrorkhuja on 27/07/22.
//

import Foundation

struct CarMarkResponse: Codable {
    let result: [CarMark]
    let error: CustomError?
}

struct CarMark: Codable {
    let id: Int
    let name: String
}
