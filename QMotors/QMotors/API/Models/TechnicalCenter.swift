//
//  TechnicalCenter.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 3.08.22.
//

import Foundation

struct TechnicalCenter: Codable {
    let id: Int
    let title: String
    let address: String
    let phone: String
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case address
        case phone
        case latitude = "lat"
        case longitude = "lng"
    }
}
