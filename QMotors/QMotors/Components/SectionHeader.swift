//
//  SectionHeader.swift
//  QMotors
//
//  Created by MIrmuxammad on 14/09/22.
//

import Foundation
import UIKit

class MyCustomHeader: UITableViewHeaderFooterView {
    let title: UILabel = {
        let label = UILabel()
        label.text = "Мои автомобили"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(title)

        title.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
    }
}
