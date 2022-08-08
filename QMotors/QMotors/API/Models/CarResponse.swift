//
//  CarResponse.swift
//  QMotors
//
//  Created by MIrmuxammad on 08/08/22.
//

import Foundation
import UIKit

struct MyCarModelResponse: Codable {
    let result: [MyCarModel]
    let error: CustomError?
}

struct MyCarModel: Codable {
    let id: Int
    let car_model_id: Int
    let user_id: Int
    let year: Int
    let status: Int
    let last_visit: String
    let vin: String
    let mileage: String
    let created_at: String
    let updated_at: String
    let number: String
    //let user_car_photos: [String]
    let model: String
    let mark: String
}
