//
//  ChatVC.swift
//  QMotors
//
//  Created by Mavlon on 01/09/22.
//

import UIKit
import IQKeyboardManagerSwift
import UniformTypeIdentifiers

class ChatVC: UIViewController {
    
    // MARK: - Proporties
    
    private let supportedTypes: [UTType] = [.jpeg, .png, .video, .avi]
    private var filePath: URL?
    
    // MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.register(ChatSupportTableViewCell.self, forCellReuseIdentifier: ChatSupportTableViewCell.identifier)
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
        return tableView
    }()
    
    private let textContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "98989B").cgColor
        return view
    }()
    
    private let attachButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "attach"), for: .normal)
        return button
    }()
    
    private let attachmentFileLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.textColor = .white
        label.font = UIFont(name: Const.fontMed, size: 14)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let removeAttachmentButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .red
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ваш текст"
        textField.font = UIFont(name: Const.fontMed, size: 18)
        return textField
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
        attachButton.addTarget(self, action: #selector(attachButtonDidTap), for: .touchUpInside)
        removeAttachmentButton.addTarget(self, action: #selector(removeAttachTapped), for: .touchUpInside)
        
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Отправить"
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(textContainer)
        textContainer.addSubview(attachButton)
        textContainer.addSubview(textField)
        view.addSubview(attachmentFileLabel)
        view.addSubview(removeAttachmentButton)
        
    }
    
    private func setupConstraints() {
        
        textContainer.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-1)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Const.lOffset)
            make.right.equalToSuperview().offset(Const.rOffset)
            make.top.equalToSuperview()
            make.bottom.equalTo(textContainer.snp.top)
        }
        
        attachButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30)
            make.right.equalToSuperview().offset(-20)
        }
        
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(attachButton.snp.left).offset(-2)
        }
        
        attachmentFileLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalTo(textField.snp.top)
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        removeAttachmentButton.snp.makeConstraints { make in
            make.centerY.equalTo(attachmentFileLabel.snp.top)
            make.centerX.equalTo(attachmentFileLabel.snp.right)
            make.width.height.equalTo(20)
        }
        
    }
    
    // MARK: - Private actions
    
    @objc private func attachButtonDidTap() {
        print("attachButtonDidTap")
        openDocumentPicker()
    }
    
    @objc private func sendButtonDidTap() {
        textField.resignFirstResponder()
        sendComment()
    }
    
    @objc private func removeAttachTapped() {
        filePath = nil
        attachmentFileLabel.isHidden = true
        attachmentFileLabel.text = nil
        removeAttachmentButton.isHidden = true
    }
    
    private func sendComment() {
        print(textField.text!)
        textField.text = nil
        attachmentFileLabel.isHidden = true
        attachmentFileLabel.text = nil
        removeAttachmentButton.isHidden = true
    }
    
}

// MARK: - UITableView Methods
extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatSupportTableViewCell.identifier, for: indexPath) as? ChatSupportTableViewCell else { return UITableViewCell() }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
            
            return cell
        }
    }
    
}

// MARK: - UITextFieldDelegate Methods
extension ChatVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let invocation = IQInvocation(self, #selector(sendButtonDidTap))
        textField.keyboardToolbar.doneBarButton.invocation = invocation
    }
}

// MARK: - UIDocumentPickerDelegate Methods
extension ChatVC: UIDocumentPickerDelegate {
    func openDocumentPicker() {
        let importDocument = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        importDocument.delegate = self
        importDocument.allowsMultipleSelection = true
        importDocument.modalPresentationStyle = .formSheet
        self.present(importDocument, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let filepathurl = urls.first else { return }
        filePath = filepathurl
        let fileName = filepathurl.lastPathComponent
        attachmentFileLabel.text = fileName
        attachmentFileLabel.isHidden = false
        removeAttachmentButton.isHidden = false
        print(fileName)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
        attachmentFileLabel.isHidden = false
        attachmentFileLabel.text = "selectedFileName.jpg"
        removeAttachmentButton.isHidden = false
    }
}
