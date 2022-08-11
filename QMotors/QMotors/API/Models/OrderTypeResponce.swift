//
//  OrderTypeResponce.swift
//  QMotors
//
//  Created by Александр Гужавин on 09.08.2022.
//

import Foundation


struct OrderTypeResponce: Codable {
    let result: [OrderType]
    let error: CustomError?
}

struct OrderType: Codable {
    let id: Int
    let name: String
}
