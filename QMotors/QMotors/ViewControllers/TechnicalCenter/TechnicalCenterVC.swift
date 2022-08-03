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
    
    let technicalCenters = TechnicalCenterData.shared.technicalCenters

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
        label.text = "Техцентры"
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
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        setupViews()
        setupConstraints()
    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(tableView)
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
    
    }
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    // MARK: - Private actions
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func phoneButtonDidTap(_ sender: UIButton) {
        print("phoneButtonDidTap \(technicalCenters[sender.tag].phoneNumber)")
        let phoneNumber = technicalCenters[sender.tag].phoneNumber

        callNumber(phoneNumber: phoneNumber.formattedPhoneNumber)
    }
    
    @objc private func navigationButtonDidTap(_ sender: UIButton) {
        print("navigationButtonDidTap \(technicalCenters[sender.tag].coordinates)")
        
        let latitude = technicalCenters[sender.tag].coordinates.coordinate.latitude
        let longitude = technicalCenters[sender.tag].coordinates.coordinate.longitude
        
        selectPreferedNaviApp(latitude: latitude, longitude: longitude)
    }
    
    @objc private func singUpButtonDidTap(_ sender: UIButton) {
        print("singUpButtonDidTap \(technicalCenters[sender.tag].title)")
    }
    
    // MARK: - Location helper
    
    private func selectPreferedNaviApp(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let actionSheet = UIAlertController(title: "Построить маршрут", message: "Выберите приложение", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Google Карты", style: .default, handler: { _ in
            guard let url = URL(string: "comgooglemaps://?daddr=\(latitude),\(longitude))&directionsmode=driving&zoom=14&views=traffic") else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Apple Карты", style: .default, handler: { _ in
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
            mapItem.name = "Destination"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
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
        cell.setupPhoneAction(target: self, action: #selector(phoneButtonDidTap(_:)))
        cell.setupNavigationAction(target: self, action: #selector(navigationButtonDidTap(_:)))
        cell.setupSignUpAction(target: self, action: #selector(singUpButtonDidTap(_:)))
        
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


