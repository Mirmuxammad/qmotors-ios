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
}
