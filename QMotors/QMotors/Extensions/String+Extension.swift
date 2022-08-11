//
//  String+Extension.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 3.08.22.
//

import Foundation

extension String {
    var formattedPhoneNumber: String {
        return "+\(components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: ""))"
    }
    
    func getDateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let newDate = dateFormatter.date(from: self)
        let returnFormatter = DateFormatter()
        returnFormatter.dateFormat = "dd.MM.yyyy"
        
        if let str = newDate {
            return returnFormatter.string(from: str)
        } else {
            return nil
        }
    }
    
    func replaceToDots(cutCount: Int, count: Int) -> String {
        if self.count >= count {
            let returner = self.prefix(cutCount) + "..."
            return String(returner)
        } else {
            return self
        }
    }
    
    func getCarRegionNumber() -> String {
        let number = self.suffix(2)
        return String(number)
    }
    
    func getCarNumber() -> String {
        let number = self.prefix(6)
        return String(number)
    }
    
}
