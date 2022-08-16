//
//  BirthdayPicker.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 9.08.22.
//

import UIKit
import SnapKit

class BirthdayPicker: UIView {

    // MARK: - UI Elements

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontMed, size: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Укажите дату вашего рождения"
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        let localeID = Locale.preferredLanguages.first
        picker.locale = Locale(identifier: localeID!)
        picker.datePickerMode = .date
        return picker
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "В день рождения начисляются \nдополнительные бонусы"
        return label
    }()

        
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(datePicker)
        addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {

        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.left.equalToSuperview()
            make.height.equalTo(55)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom)
            make.left.equalToSuperview()
        }
 
    }
    
    // MARK: - Public function
    
   
}
