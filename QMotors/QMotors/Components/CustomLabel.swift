//
//  CustomLabel.swift
//  QMotors
//
//  Created by Akhrorkhuja on 26/07/22.
//

import UIKit

enum FontWeight: String {
    case regular =  "Montserrat-Regular"
    case medium = "Montserrat-Medium"
    case semiBold = "Montserrat-SemiBold"
}

class CustomLabel: UILabel {

    // MARK: - Initialization
    init(text: String, size: CGFloat = 16, fontWeight: FontWeight = .regular, color: UIColor = .black) {
        super.init(frame: .zero)
        configure(text: text, size: size, fontWeight: fontWeight, color: color)
    }
    
    init(text: String, fontWeight: FontWeight = .regular) {
        super.init(frame: .zero)
        configure(text: text, size: 16, fontWeight: fontWeight, color: .black)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func configure(text: String, size: CGFloat, fontWeight: FontWeight, color: UIColor) {
        self.text = text
        self.font = .init(name: fontWeight.rawValue, size: CGFloat(size))
        self.textColor = color
    }

}
