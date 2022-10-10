//
//  TechnicalCenterVC.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 28.07.22.
//

import UIKit
import SnapKit
import CoreLocation
import MapKit

class TechnicalCenterVC: BaseVC {
    
    // MARK: - Properties
    
    var technicalCenters = [TechnicalCenter]()

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
        label.text = "Автосервисы"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(TechnicalCenterTableViewCell.self, forCellReuseIdentifier: TechnicalCenterTableViewCell.identifier)
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
        loadTechCenters()
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
            make.top.equalToSuperview().offset(20)
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
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func showRegisterAlert() {
        let alert = UIAlertController(title: "Зарегистрироваться?", message: "Записаться на ТО могут только зарегистрированные пользователи", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Регистрация", style: .default) { _ in
            self.router?.pushRegistrationVC()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Load tech centers
    
    private func loadTechCenters() {
        activityIndicator.startAnimating()
        TechCenterAPI.techCenterList { [weak self] jsonData in
            guard let self = self else { return }
            self.technicalCenters = jsonData
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }

    // MARK: - Private actions
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func phoneButtonDidTap(_ sender: UIButton) {
        print("phoneButtonDidTap \(technicalCenters[sender.tag].phone)")
        let phoneNumber = technicalCenters[sender.tag].phone

        callNumber(phoneNumber: phoneNumber.formattedPhoneNumber)
    }
    
    @objc private func navigationButtonDidTap(_ sender: UIButton) {
        print("navigationButtonDidTap \(technicalCenters[sender.tag].latitude), \(technicalCenters[sender.tag].longitude)", sender.tag)
        
        let latitude = technicalCenters[sender.tag].latitude
        let longitude = technicalCenters[sender.tag].longitude
        let name = technicalCenters[sender.tag].title
        
        selectPreferedNaviApp(latitude: latitude, longitude: longitude, name: name)
    }
    
    @objc private func singUpButtonDidTap(_ sender: UIButton) {
        print("singUpButtonDidTap \(technicalCenters[sender.tag].title)")
        
        if UserDefaultsService.sharedInstance.authToken != nil {
            router?.pushTechnicalRecordVCWhithID(id: technicalCenters[sender.tag].id)
        } else {
            showRegisterAlert()
        }
        
    }
    
    // MARK: - Location helper
    
    private func selectPreferedNaviApp(latitude: String, longitude: String, name: String) {
        let actionSheet = UIAlertController(title: "Построить маршрут", message: "Выберите приложение", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Google Карты", style: .default, handler: { _ in
            guard let url = URL(string: "comgooglemaps://?daddr=\(latitude),\(longitude))&directionsmode=driving&zoom=14&views=traffic") else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Apple Карты", style: .default, handler: { _ in

            guard
                let lat = Double(latitude),
                let lon = Double(longitude) else { return }
            
            let regionDistance: CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(lat, lon)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = name
            mapItem.openInMaps(launchOptions: options)


        }))
        
        actionSheet.addAction(UIAlertAction(title: "Yandex Карты", style: .default, handler: { _ in
            guard let url = URL(string: "yandexmaps://maps.yandex.ru/?ll=\(longitude),\(latitude)&z=12&l=map") else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension TechnicalCenterVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        technicalCenters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: TechnicalCenterTableViewCell.identifier, for: indexPath) as? TechnicalCenterTableViewCell
        else { return UITableViewCell() }
        cell.setupCell(technicalCenters[indexPath.row])
        cell.setupPhoneAction(target: self, action: #selector(phoneButtonDidTap(_:)), index: indexPath.row)
        cell.setupNavigationAction(target: self, action: #selector(navigationButtonDidTap(_:)), index: indexPath.row)
        cell.setupSignUpAction(target: self, action: #selector(singUpButtonDidTap(_:)), index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
}

// MARK: - UITableViewDelegate
extension TechnicalCenterVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt - \(indexPath.row)")
    }
}


