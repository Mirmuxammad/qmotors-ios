//
//  SideMenuVC.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 13.07.22.
//

import UIKit
import SnapKit

class SideMenuVC: UIViewController, Routable {
    
    // MARK: - Properties
    
    var router: MainRouter?
    var rootScreen: RootScreen?
    
    var cellMenuItemsArray = [
        NSLocalizedString("ГЛАВНАЯ", comment: ""),
         NSLocalizedString("ЛИЧНЫЙ КАБИНЕТ", comment: ""),
         NSLocalizedString("ЗАПИСЬ", comment: ""),
         NSLocalizedString("ТЕХЦЕНТРЫ", comment: ""),
         NSLocalizedString("АКЦИИ", comment: ""),
         NSLocalizedString("УВЕДОМЛЕНИЕ", comment: ""),
         NSLocalizedString("ОТЗЫВЫ", comment: ""),
         NSLocalizedString("ЧАТ", comment: ""),
         NSLocalizedString("СТАТЬИ", comment: ""),
         NSLocalizedString("ПОМОЩЬ", comment: ""),
         NSLocalizedString("ШТРИХ-КОД", comment: ""),
         NSLocalizedString("БЕСПЛАТНАЯ ДИАГНОСТИКА", comment: "")]
    
    
    // MARK: - UI Elements
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "medium_logo")
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let locationButton: RouteButton = {
        let button = RouteButton()
        button.setupButton(target: self, action: #selector(locationButtonDidTap))
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
        setupViews()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        router?.navigationController.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        
        view.addSubview(closeButton)
        view.addSubview(logoImageView)
        view.addSubview(tableView)
        view.addSubview(locationButton)
    }
    
    private func setupConstraints() {
        
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(20)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 150, height: 63))
            make.top.equalTo(closeButton.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(25)
            make.right.equalTo(view)
            make.left.equalTo(view).offset(-20)
            make.bottom.equalTo(locationButton.snp.top)
        }
        
        locationButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(130)
        }
    }
    
    // MARK: - Private actions
    
    @objc private func closeButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc private func locationButtonDidTap() {
        print("locationButtonDidTap")
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellMenuItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier, for: indexPath) as? SideMenuTableViewCell else {
            return UITableViewCell()
        }
        
        let name = cellMenuItemsArray[indexPath.row]
        cell.cellSideMenuConfigure(name: name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // dismiss(animated: true)
        
        switch indexPath.row {
        case 0:
            dismiss(animated: true)
            router?.pushMainVC()
        case 1:
            dismiss(animated: true)
            if UserDefaultsService.sharedInstance.authToken != nil {
                router?.pushCabinetVC()
            } else {
                router?.pushRegistrationVC()
            }
        case 2:
            dismiss(animated: true)
        case 3:
            dismiss(animated: true)
            router?.pushTechnicalCenterVC()
        case 4:
            dismiss(animated: true)
        case 5:
            dismiss(animated: true)
        case 6:
            dismiss(animated: true)
        case 7:
            dismiss(animated: true)
        case 8:
            dismiss(animated: true)
        case 9:
            dismiss(animated: true)
        case 10:
            dismiss(animated: true)
        case 11:
            dismiss(animated: true)
        default:
            print("__Tap__")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
}
