//
//  UserDefaults.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 22.07.22.
//

import Foundation

class UserDefaultsService {
    
    public static let sharedInstance = UserDefaultsService()

    private enum Keys {
        static let authToken = "authToken"
        static let techCenters = "techCenters"
    }

    func removeAuthToken() {
        self.authToken = nil
    }
        
    var authToken: String? {
        get {
            let authToken = UserDefaults.standard.value(forKey: Keys.authToken) as? String
            return authToken ?? nil
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.authToken)
        }
    }
    
    var centras: [String]? {
        get {
            let centras = UserDefaults.standard.value(forKey: Keys.techCenters) as? [String]
            return centras ?? nil
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.techCenters)
        }
    }

}


