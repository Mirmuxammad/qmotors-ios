//
//  MyRemindersVC.swift
//  QMotors
//
//  Created by MIrmuxammad on 22/08/22.
//

import UIKit
import SnapKit

class MyRemindersVC: BaseVC {
    
    // MARK: - Properties
    
    var myCars = [MyCarModel]()
    var reminders = [Reminder]()
    var car: MyCarModel?
    
    // MARK: - UI Elements
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "small_logo")
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let backButton: SmallBackButton = {
        let button = SmallBackButton()
        button.setupAction(target: self, action: #selector(backButtonDidTap))
        return button
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Все напоминания"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(MyRamindersTableViewCell.self, forCellReuseIdentifier: MyRamindersTableViewCell.identifier)
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadInfo()
    }
    
    override func leftMenuButtonDidTap() {
        sideMenuVC.rootScreen = .techCenter
        super.leftMenuButtonDidTap()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(tableView)
        view.addSubview(activityIndicator)
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
            make.height.equalTo(22)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
    private func showRegisterAlert() {
        let alert = UIAlertController(title: "Удалит", message: "Вы уверены что хотите удалить напоминание?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Да", style: .default) { _ in
            self.deleteReminder()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Loads
    
    private func loadInfo() {
        self.showLoadingIndicator()
        let dg = DispatchGroup()
//        loadMyCar(dg: dg)
        loadReminders()
        tableView.reloadData()
    }
    
    // MARK: - Load Reminders
    
    private func loadReminders() {
        activityIndicator.startAnimating()
        ReminderAPI.remindersList { [weak self] jsonData in
            self?.reminders = jsonData
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
            self?.dismissLoadingIndicator()
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
//    // MARK: - Load Cars
//
//    private func loadMyCar(dg: DispatchGroup) {
//        dg.enter()
//        CarAPI.getMyCars { [weak self] jsonData in
//            guard let self = self else { return }
//            self.myCars = jsonData
//            dg.leave()
//            self.dismissLoadingIndicator()
//        } failure: { error in
//            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//            }))
//            self.present(alert, animated: true, completion: nil)
//
//            dg.leave()
//        }
//    }

    // MARK: - Delete Raminder
    
    private func deleteReminder() {
        
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func deleteDidTap() {
        
    }
    
    @objc private func editDidTap() {
        
    }
}

// MARK: - UITableViewDataSource
extension MyRemindersVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: MyRamindersTableViewCell.identifier, for: indexPath) as? MyRamindersTableViewCell
        else { return UITableViewCell() }
        
        for i in myCars {
            if i.id == reminders[indexPath.row].user_car_id {
                car = i
            }
        }
        
        reminders.sort { date1, date2 in
            (date1.date?.getStringDate())! > (date2.date?.getStringDate())!
        }
        
        if let date = reminders[indexPath.row].date?.getStringDate() {
            if date >= Date() {
                cell.setupCell(reminder: reminders[indexPath.row], car: car!)
            } else {
                cell.setupLastCells(reminder: reminders[indexPath.row], car: car!)
            }
        }
        cell.deleteReminder(target: self, action: #selector(deleteDidTap), index: indexPath.row)
        cell.editRiminder(target: self, action: #selector(editDidTap), index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let date = reminders[indexPath.row].date?.getStringDate() {
            if date >= Date() {
                return 180
            } else {
                return 140
            }
        } else {
            return 180
        }
    }
    
}

// MARK: - UITableViewDelegate
extension MyRemindersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt - \(indexPath.row)")
    }
}
