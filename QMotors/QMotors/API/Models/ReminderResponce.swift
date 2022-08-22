//
//  ReminderResponce.swift
//  QMotors
//
//  Created by MIrmuxammad on 22/08/22.
//

import Foundation
import UIKit

struct Reminder: Codable {
    let user_car_id: Int?
    let date: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case user_car_id
        case date
        case text
    }
}
