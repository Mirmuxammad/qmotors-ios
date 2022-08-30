//
//  NotificationService.swift
//  QMotors
//
//  Created by MIrmuxammad on 30/08/22.
//

import Foundation
import UserNotifications

class NotificationService: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared = NotificationService()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func userRequest(_ completed: @escaping (Bool) -> Void) {
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
                completed(false)
                
            } else {
                print("User has accepted notifications")
                self.notificationCenter.delegate = self
                completed(true)
            }
            
            if error != nil {
                print(error.debugDescription)
            }
        }
    }
    
    func showNotification(with item: (String, String), showBody: Bool, withAction: Bool, atDate date: Date) {
        let content = UNMutableNotificationContent()
        
        let userActionsIdentifier = "showMe"
        content.title = item.0
        
        if showBody { content.body = item.1 }
        
        content.userInfo = [item.0: item.1]
        content.sound = UNNotificationSound.default
        
        if withAction { content.categoryIdentifier = userActionsIdentifier }
        
        let notificationID = item.0
        
        var dc = DateComponents()
        dc.hour = Calendar.current.component(.hour, from: date)
        dc.minute = Calendar.current.component(.minute, from: date)
        dc.second = Calendar.current.component(.second, from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dc, repeats: false)
        
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            error == nil ? print("notifacation request was added at ", trigger.nextTriggerDate()!) :
                           print(error.debugDescription)
        }
        
        let action = UNNotificationAction(identifier: "showMe", title: "Show me", options: [])
        
        let category = UNNotificationCategory(identifier:userActionsIdentifier, actions: [action],
                                              intentIdentifiers: [], options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    // MARK: - Delegates Methods
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("... notification presented")
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("didReceive response")
        
        switch response.actionIdentifier {
        case "showMe":
            print("showMe action")
            
            let mainText = response.notification.request.content.userInfo.keys.first! as! String
            
            let subText = response.notification.request.content.userInfo.values.first! as! String
            
            self.showNotification(with: (mainText, subText), showBody: true, withAction: false,
                                  atDate: Date())
            
        default:
            print("defaul action")
        }
        
        completionHandler()
    }

}

