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
        returnFormatter.dateFormat = "yyyy-MM-dd"
        
        if let str = newDate {
            return returnFormatter.string(from: str)
        } else {
            return nil
        }
    }
}
