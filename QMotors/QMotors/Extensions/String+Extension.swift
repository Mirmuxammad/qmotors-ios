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
        
        let date = formatter.date(from: String(str))!
        formatter.dateFormat = "dd.MM.yyyy"
        
        let result = formatter.string(from: date)
        
        return result
    }
}
