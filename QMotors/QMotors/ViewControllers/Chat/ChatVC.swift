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
import ImageSlideshow

class ChatVC: BaseVC {
    
    // MARK: - Proporties
    
    private var messages = [Message]()
    private let supportedTypes: [UTType] = [.jpeg, .png, .video, .avi, .pdf, .mpeg]
    private var fileURL: URL?
    private var timer: Timer?
    private var isOpenedFirstTime = true
    
    // MARK: - UI Elements
    
    private let backButton: SmallBackButton = {
        let button = SmallBackButton()
        button.setupAction(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "small_logo")
        return imageView
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Чат"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
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
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.text = "Ваш текст"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont(name: Const.fontMed, size: 18)
        return textView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    private var slideshow: ImageSlideshow = {
        let slideshow = ImageSlideshow()
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.activityIndicator = DefaultActivityIndicator()
        return slideshow
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupHideKeyboardOnTapView()
        
        tableView.delegate = self
        tableView.dataSource = self
        textView.delegate = self
        
        attachButton.addTarget(self, action: #selector(attachButtonDidTap), for: .touchUpInside)
        removeAttachmentButton.addTarget(self, action: #selector(removeAttachTapped), for: .touchUpInside)
        
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Отправить"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMessages()
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(loadAgain), userInfo: nil, repeats: true)
    }
    
    override func leftMenuButtonDidTap() {
        sideMenuVC.rootScreen = .techCenter
        super.leftMenuButtonDidTap()
    }
    
    @objc private func loadAgain() {
        loadMessages()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(tableView)
        backgroundView.addSubview(textContainer)
        textContainer.addSubview(attachButton)
        textContainer.addSubview(textView)
        backgroundView.addSubview(attachmentFileLabel)
        backgroundView.addSubview(removeAttachmentButton)
        backgroundView.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 55, height: 55))
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 23))
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(40)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.height.equalTo(24)
        }
        
        textContainer.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-1)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Const.lOffset)
            make.right.equalToSuperview().offset(Const.rOffset)
            make.top.equalTo(titleLable.snp.bottom).offset(10)
            make.bottom.equalTo(textContainer.snp.top)
        }
        
        attachButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30)
            make.right.equalToSuperview().offset(-20)
        }
        
        textView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.right.equalTo(attachButton.snp.left).offset(-2)
        }
        
        attachmentFileLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalTo(textView.snp.top)
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
        isOpenedChat = false
        timer?.invalidate()
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
        sendMessage(message: textView.text!)
        textView.text = nil
        textContainer.snp.remakeConstraints { make in
            make.height.equalTo(55)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-1)
        }
        attachmentFileLabel.isHidden = true
        attachmentFileLabel.text = nil
        removeAttachmentButton.isHidden = true
    }
    
    // MARK: - API Methods
    
    private func loadMessages() {
        if isOpenedFirstTime {
            activityIndicator.startAnimating()
        }
        ChatAPI.getMessages { messages in
            
            self.messages = messages
            self.tableView.reloadData()
            if self.isOpenedFirstTime {
                self.tableView.scrollToBottom(isAnimated: false)
            }
            self.activityIndicator.stopAnimating()
            self.isOpenedFirstTime = false
            
        } failure: { error in
            self.activityIndicator.stopAnimating()
            if let error = error {
                print(error.localizedDescription)
                //alert
            }
            self.isOpenedFirstTime = false
        }
    }
    
    private func sendMessage(message: String) {
        activityIndicator.startAnimating()
        
        guard let fileURL = fileURL else {
            if message != "" {
                ChatAPI.sendOnly(message: message) { data in
                    print(data["result"])
                    self.isOpenedFirstTime = true
                    self.loadMessages()
                } failure: { error in
                    self.showAlert(with: error?.localizedDescription ?? "Ошибка", buttonTitle: "Ок")
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
                self.isOpenedFirstTime = true
                self.loadMessages()
                self.activityIndicator.stopAnimating()
                
            } failure: { error in
                self.showAlert(with: error?.localizedDescription ?? "Ошибка", buttonTitle: "Ок")
                self.activityIndicator.stopAnimating()
                //alert
            }
            
        } else if fileExtension == "avi" || fileExtension == "mp4" || fileExtension == "mpeg" {
            
            ChatAPI.sendMessage(fileType: .video, message: message, fileUrlArray: [fileURL]) { data in
                
                print(data["result"])
                self.isOpenedFirstTime = true
                self.loadMessages()
                self.activityIndicator.stopAnimating()
                
            } failure: { error in
                self.showAlert(with: error?.localizedDescription ?? "Ошибка", buttonTitle: "Ок")
                self.activityIndicator.stopAnimating()
                //alert
            }
            
        } else {
            
            ChatAPI.sendMessage(fileType: .file, message: message, fileUrlArray: [fileURL]) { data in
                
                print(data["result"])
                self.isOpenedFirstTime = true
                self.loadMessages()
                self.activityIndicator.stopAnimating()
                
            } failure: { error in
                self.showAlert(with: error?.localizedDescription ?? "Ошибка", buttonTitle: "Ок")
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

extension ChatVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        let invocation = IQInvocation(self, #selector(sendButtonDidTap))
        textView.keyboardToolbar.doneBarButton.invocation = invocation
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == nil {
            textView.text = "Ваш текст"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textContainer.snp.remakeConstraints { make in
            make.height.equalTo(textView.contentSize.height + 17)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-1)
        }
        
//        self.view.layoutIfNeeded()
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
    
    func openFileDidTap(fileType: FileType, filePath: String, btn: UIButton) {
        
        switch fileType {
        case .file:
            if let fileURL = URL(string: BaseAPI.baseURL + filePath) {
                shareFile(url: fileURL, btn: btn)
            }
        case .video:
            if let fileURL = URL(string: BaseAPI.baseURL + filePath) {
                playVideo(url: fileURL)
            }
        case .photo:
            if let fileURL = URL(string: BaseAPI.baseURL + filePath) {
                openImage(url: fileURL)
            }
        case .none:
            break
        }
        
    }
    
    private func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        
        let vc = AVPlayerViewController()
        vc.player = player
        
        self.present(vc, animated: true) { vc.player?.play() }
    }
    
    private func shareFile(url: URL, btn: UIButton) {
        let objectsToShare = [url] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        if #available(iOS 15.4, *) {
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.sharePlay, UIActivity.ActivityType.openInIBooks, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.markupAsPDF]
        } else {
            // Fallback on earlier versions
        }
        
        activityVC.popoverPresentationController?.sourceView = btn
        self.present(activityVC, animated: true, completion: nil)
    }
    
    private func openImage(url: URL) {
        let imageSource: [SDWebImageSource] = [SDWebImageSource(url: url)]
        slideshow.setImageInputs(imageSource)
        slideshow.presentFullScreenController(from: self, completion: nil)
    }
}
