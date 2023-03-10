//
//  StockResponce.swift
//  QMotors
//
//  Created by MIrmuxammad on 06/09/22.
//

import Foundation

struct Stock: Codable {
    var id: Int?
    var title: String?
    var subtitle: String?
    var location: String?
    var description: String?
    var created_at: String?
    var updated_at: String?
    var text: String?
}

struct StockResponse: Codable {
    let result: Stock
}
