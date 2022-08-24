//
//  ReminderAPI.swift
//  QMotors
//
//  Created by MIrmuxammad on 21/08/22.
//

import Foundation
import Alamofire
import SwiftyJSON


final class ReminderAPI {
    static func addNewReminder(reminder: NewReminder, success: @escaping (String) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = ["user_car_id": reminder.user_car_id,
                                  "date": reminder.date,
                                  "text": reminder.text]
        
        BaseAPI.authorizedPostRequest(reqMethod: .reminder, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                print(jsonData["result"])
                success("ordertypes")
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func remindersList(success: @escaping ([Reminder]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .getReminder, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var reminders = [Reminder]()
                for reminder in jsonData["result"].arrayValue {
                    reminders.append(Reminder(user_car_id: reminder["user_car_id"].intValue, date: reminder["date"].stringValue, text: reminder["text"].stringValue))
                }
                success(reminders)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func deleteReminders(reminderId: Int, success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedDeleteRequest(reqMethod: .deleteReminder(reminderId), parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                success(jsonData["result"])
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
}
