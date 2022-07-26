//
//  UISegmentedControl+Extension.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 23.07.22.
//

import UIKit

extension UISegmentedControl {
     func setTitleColor(_ color: UIColor, state: UIControl.State = .normal) {
         var attributes = self.titleTextAttributes(for: state) ?? [:]
         attributes[.foregroundColor] = color
         self.setTitleTextAttributes(attributes, for: state)
     }
     
     func setTitleFont(_ font: UIFont, state: UIControl.State = .normal) {
         var attributes = self.titleTextAttributes(for: state) ?? [:]
         attributes[.font] = font
         self.setTitleTextAttributes(attributes, for: state)
     }
 }
