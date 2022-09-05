//
//  NSAttributedString + Extension.swift
//  QMotors
//
//  Created by Александр Гужавин on 31.08.2022.
//

import Foundation

extension NSAttributedString {
        internal convenience init?(html: String) {
            guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
                // not sure which is more reliable: String.Encoding.utf16 or String.Encoding.unicode
                return nil
            }
            guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
                return nil
            }
            self.init(attributedString: attributedString)
        }
}
