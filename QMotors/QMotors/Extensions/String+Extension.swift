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

    func getFormattedDate() -> String {
        let str = self.prefix(10)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
<<<<<<< HEAD
        let date = formatter.date(from: String(str)) ?? Date()
=======
        let date = formatter.date(from: String(str))
>>>>>>> 4b9dce5e61b9f9e5ea10b7be97dfabe0e3d2237c
        formatter.dateFormat = "dd.MM.yyyy"
        
        guard let date = date else {
            return ""
        }
        
        let result = formatter.string(from: date)
        
        return result
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
        let regionNumberthree = self.suffix(3)
        let regionNumberTwo = self.suffix(2)
        if self.count == 9 {
            return String(regionNumberthree)
        } else {
            return String(regionNumberTwo)
        }
    }
    
    func getCarNumber() -> String {
        let number = self.prefix(6)
        return String(number)
    }
    
    func getMillageNumber() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        
        let millage = NSNumber(pointer: self)
        let formatMillage = formatter.string(from: millage) ?? ""
        return formatMillage
    }
}
