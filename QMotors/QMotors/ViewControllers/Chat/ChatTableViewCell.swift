//
//  ChatTableViewCell.swift
//  QMotors
//
//  Created by Mavlon on 01/09/22.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "ChatTableViewCell"
    var delegate: OpeningFileDelegate?
    private var currentFileType = FileType.none
    private var currentFileURL: String?
    
    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
        view.backgroundColor = UIColor(hex: "9CC55A")
        return view
    }()
    
    private let chatLabel: UILabel = {
        let label = UILabel()
        label.text = "Зарегистрируйтесь в приложении, воспользйтесь кнопкой тех. центры, заполните все предоставленые ячейки, нажмите кнопку и наши мастера будут вас ждать"
        label.font = UIFont(name: Const.fontMed, size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let chatStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let attachmentButton: UIButton = {
        let button = UIButton()
        button.setTitle("  photo.jpg", for: .normal)
        button.setImage(UIImage(named: "attach"), for: .normal)
        button.tintColor = .white
        button.titleLabel?.textAlignment = .left
        button.isHidden = true
        button.addTarget(self, action: #selector(openFileButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 12)
        label.text = "12.10.2022  |  16:44"
        label.textColor = .black
        return label
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
    
    func setupCell(with message: Message) {
        chatLabel.text = message.message
        dateLabel.text = message.created_at.getFormattedDate() + " | " + message.created_at.prefix(16).suffix(5)
         // fix to dynamic checking whether file exists or not

        switch message.filetype {
            
        case .file:
            attachmentButton.isHidden = false
            attachmentButton.setTitle("  file", for: .normal)
            currentFileURL = message.file
            currentFileType = .file
        case .video:
            attachmentButton.isHidden = false
            attachmentButton.setTitle("  video", for: .normal)
            currentFileURL = message.video
            currentFileType = .video
        case .photo:
            attachmentButton.isHidden = false
            attachmentButton.setTitle("  photo", for: .normal)
            currentFileURL = message.photo
            currentFileType = .photo
        case .none:
            attachmentButton.isHidden = true
            currentFileType = .none
            currentFileURL = nil
        }
    }
    
    // MARK: - Private Action
    
    @objc func openFileButtonDidTap() {
        guard let currentFileURL = currentFileURL, currentFileType != .none else {
            return
        }

        delegate?.openFileDidTap(fileType: currentFileType, filePath: currentFileURL, btn: attachmentButton)
    }
    
        
    // MARK: - Private functions
    
    private func setupViews() {
        contentView.addSubview(containerView)
        contentView.addSubview(dateLabel)
        containerView.addSubview(chatStack)
        chatStack.addArrangedSubview(chatLabel)
        chatStack.addArrangedSubview(attachmentButton)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview()
            make.bottom.equalTo(dateLabel.snp.top).offset(-4)
            make.left.equalToSuperview().offset(50)
//            make.height.equalTo(100)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(22)
        }
        
        chatStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
        }
        
        attachmentButton.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
    }

}

// MARK: Protocol OpeningFileDelegate
protocol OpeningFileDelegate {
    func openFileDidTap(fileType: FileType, filePath: String, btn: UIButton)
}
