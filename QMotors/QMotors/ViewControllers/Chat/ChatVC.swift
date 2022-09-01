//
//  ChatVC.swift
//  QMotors
//
//  Created by Mavlon on 01/09/22.
//

import UIKit
import IQKeyboardManagerSwift

class ChatVC: UIViewController {
    
    // MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
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
        button.addTarget(self, action: #selector(attachButtonDidTap), for: .touchUpInside)
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
        
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Отправить"
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(textContainer)
        view.addSubview(tableView)
        textContainer.addSubview(attachButton)
        textContainer.addSubview(textField)
        
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
        
    }
    
    // MARK: - Private actions
    
    @objc private func attachButtonDidTap() {
        print("attachButtonDidTap")
    }
    
    @objc private func sendButtonDidTap() {
        textField.resignFirstResponder()
        sendComment()
    }
    
    private func sendComment() {
        print(textField.text!)
        textField.text = nil
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
