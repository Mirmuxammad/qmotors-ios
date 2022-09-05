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
        

        let date = formatter.date(from: String(str))
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
    
    func getStringDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let newDate = dateFormatter.date(from: self)
        if let date = newDate {
            return date
        } else {
            return Date()
        }
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
