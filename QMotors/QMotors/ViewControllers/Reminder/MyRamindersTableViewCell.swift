//
//  MyRamindersTableViewCell.swift
//  QMotors
//
//  Created by MIrmuxammad on 22/08/22.
//

import UIKit

protocol getNumber {
    func editReminder(reminder: NewReminder)
    func deleteReminder(index: Int)
}

class MyRamindersTableViewCell: UITableViewCell {

    
    static let identifier = "MyRamindersTableViewCell"
    var reminder: Reminder?
    var delegate: getNumber?
    
    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#9CC55A")
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bellRinging")
        return imageView
    }()
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontBold, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Субару"
        return label
    }()
    
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontBold, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Напомним 24.01.208 | 16:30"
        return label
    }()
    
    private let reminderTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 3
        label.text = "Здесь будет текст напоминания, который ввел клиент при его создании"
        return label
    }()
    
    private let deleteButton: ReminderCellButton = {
        let button = ReminderCellButton()
        button.setupAction(target: self, action: #selector(deleteButtonDidTap))
        return button
    }()
    
    private let editButton: ReminderCellEditButton = {
        let button = ReminderCellEditButton()
        button.setupAction(target: self, action: #selector(editButtonDidTap))
        return button
    }()
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(reminderTextLabel)
        containerView.addSubview(reminderTextLabel)
        containerView.addSubview(deleteButton)
        containerView.addSubview(editButton)
        
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 32, height: 32))
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.left.equalTo(logoImageView.snp.right).offset(16)
            make.height.equalTo(14)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(21)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        
        reminderTextLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.top.equalToSuperview().offset(25)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.right.equalTo(editButton.snp.left).offset(-16)
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.top.equalToSuperview().offset(25)
        }

        
    }
    
    // MARK: - Private actions
    
    @objc private func deleteButtonDidTap() {
        guard let id = reminder?.id else { return }
        delegate?.deleteReminder(index: id)
    }
    
    @objc private func editButtonDidTap() {
        delegate?.editReminder(reminder: NewReminder(id: reminder?.id, user_car_id: reminder?.user_car_id, date: reminder?.date, text: reminder?.text))
    }
    
        
    // MARK: - Public functions
    
    func setupCell(reminder: Reminder, car: MyCarModel) {
        self.reminder = reminder
        titleLabel.text = car.model
        if let date = reminder.date {
            dateLabel.text = "Напомним \(date)"
        }
        reminderTextLabel.text = reminder.text
    }
    
    func setupLastCells(reminder: Reminder, car: MyCarModel) {
        containerView.backgroundColor = UIColor.init(hex: "#5A80C0")
        titleLabel.text = car.model
        dateLabel.isHidden = true
        reminderTextLabel.text = reminder.text
    }
    
}
