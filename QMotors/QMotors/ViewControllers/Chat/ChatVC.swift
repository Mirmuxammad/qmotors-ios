//
//  ChatVC.swift
//  QMotors
//
//  Created by Mavlon on 01/09/22.
//

import UIKit
import IQKeyboardManagerSwift
import UniformTypeIdentifiers
import AVKit
import AVFoundation

class ChatVC: UIViewController, Routable {
    
    // MARK: - Proporties
    
    var router: MainRouter?
    private var messages = [Message]()
    private let supportedTypes: [UTType] = [.jpeg, .png, .video, .avi, .pdf, .mpeg]
    private var fileURL: URL?
    
    // MARK: - UI Elements
    
    private let backButton: SmallBackButton = {
        let button = SmallBackButton()
        button.setupAction(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadMessages()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(backButton)
        view.addSubview(tableView)
        view.addSubview(textContainer)
        textContainer.addSubview(attachButton)
        textContainer.addSubview(textField)
        view.addSubview(attachmentFileLabel)
        view.addSubview(removeAttachmentButton)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(Const.lOffset)
            make.size.equalTo(CGSize(width: 100, height: 23))
        }
        
        textContainer.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-1)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Const.lOffset)
            make.right.equalToSuperview().offset(Const.rOffset)
            make.top.equalTo(backButton.snp.bottom).offset(10)
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
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
    // MARK: - Private actions
    
    @objc private func attachButtonDidTap() {
        print("attachButtonDidTap")
        openDocumentPicker()
    }
    
    @objc private func backButtonDidTap() {
        router?.back()
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
    }
    
    @objc private func sendButtonDidTap() {
        textField.resignFirstResponder()
        sendComment()
    }
    
    @objc private func removeAttachTapped() {
        fileURL = nil
        attachmentFileLabel.isHidden = true
        attachmentFileLabel.text = nil
        removeAttachmentButton.isHidden = true
    }
    
    private func sendComment() {
        sendMessage(message: textField.text!)
        textField.text = nil
        attachmentFileLabel.isHidden = true
        attachmentFileLabel.text = nil
        removeAttachmentButton.isHidden = true
    }
    
    // MARK: - API Methods
    
    private func loadMessages() {
        activityIndicator.startAnimating()
        ChatAPI.getMessages { messages in
            
            self.messages = messages
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            
        } failure: { error in
            self.activityIndicator.stopAnimating()
            if let error = error {
                print(error.localizedDescription)
                //alert
            }
        }

    }
    
    private func sendMessage(message: String) {
        activityIndicator.startAnimating()
        
        guard let fileURL = fileURL else {
            if message != "" {
                ChatAPI.sendOnly(message: message) { data in
                    print(data["result"])
                    self.loadMessages()
                } failure: { error in
                    print(error?.localizedDescription)
                    self.activityIndicator.stopAnimating()
                    //alert
                }
            }
            activityIndicator.stopAnimating()
            return
        }
        
        let fileExtension = fileURL.pathExtension
        
        if fileExtension == "jpg" || fileExtension == "jpeg" || fileExtension == "png" {
            
            ChatAPI.sendMessage(fileType: .photo, message: message, fileUrlArray: [fileURL]) { data in
                
                print(data["result"])
                self.loadMessages()
                self.activityIndicator.stopAnimating()
                
            } failure: { error in
                print(error?.localizedDescription)
                self.activityIndicator.stopAnimating()
                //alert
            }
            
        } else if fileExtension == "avi" || fileExtension == "mp4" || fileExtension == "mpeg" {
            
            ChatAPI.sendMessage(fileType: .video, message: message, fileUrlArray: [fileURL]) { data in
                
                print(data["result"])
                self.loadMessages()
                self.activityIndicator.stopAnimating()
                
            } failure: { error in
                print(error?.localizedDescription)
                self.activityIndicator.stopAnimating()
                //alert
            }
            
        } else {
            
            ChatAPI.sendMessage(fileType: .file, message: message, fileUrlArray: [fileURL]) { data in
                
                print(data["result"])
                self.loadMessages()
                self.activityIndicator.stopAnimating()
                
            } failure: { error in
                print(error?.localizedDescription)
                self.activityIndicator.stopAnimating()
                //alert
            }
            
        }
        activityIndicator.stopAnimating()
        
    }
    
}

// MARK: - UITableView Methods
extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.admin_user_id != nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatSupportTableViewCell.identifier, for: indexPath) as? ChatSupportTableViewCell else { return UITableViewCell() }
            cell.setupCell(with: message)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
            cell.setupCell(with: message)
            cell.delegate = self
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
        fileURL = filepathurl
        let fileName = filepathurl.lastPathComponent
        attachmentFileLabel.text = fileName
        attachmentFileLabel.isHidden = false
        removeAttachmentButton.isHidden = false
        print(fileName)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
//        attachmentFileLabel.isHidden = false
//        attachmentFileLabel.text = "selectedFileName.jpg"
//        removeAttachmentButton.isHidden = false
    }
}

// MARK: - OpeningFileDelegate
extension ChatVC: OpeningFileDelegate {
    
    func openFileDidTap(fileType: FileType, filePath: String) {
        
        switch fileType {
        case .file:
            return //implement sharing file or save
        case .video:
            if let fileURL = URL(string: BaseAPI.baseURL + filePath) {
                playVideo(url: fileURL)
            }
        case .photo:
            return //implement opening photo
        case .none:
            break
        }
        
    }
    
    func playVideo(url: URL) {
            let player = AVPlayer(url: url)
            
            let vc = AVPlayerViewController()
            vc.player = player
            
            self.present(vc, animated: true) { vc.player?.play() }
        }
    
}
