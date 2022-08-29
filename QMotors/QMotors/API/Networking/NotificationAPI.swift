//
//  NotificationAPI.swift
//  QMotors
//
//  Created by Mavlon on 26/08/22.
//

import Foundation
import Alamofire
import SwiftyJSON

final class NotificationAPI {
    static func notificationList(success: @escaping ([NotificationLocal]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .notification, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var notifications = [NotificationLocal]()
                for notification in jsonData["result"].arrayValue {
                    notifications.append(NotificationLocal(id: notification["id"].intValue,
                                                      title: notification["title"].stringValue,
                                                      text: notification["text"].stringValue,
                                                      user_id: notification["user_id"].intValue,
                                                      created_at: notification["created_at"].stringValue,
                                                      updated_at: notification["updated_at"].stringValue,
                                                      notification_type: notification["notification_type"].intValue))
                }
                success(notifications)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
}
