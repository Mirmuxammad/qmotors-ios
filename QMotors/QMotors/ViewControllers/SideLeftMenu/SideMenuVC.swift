//
//  SideMenuVC.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 13.07.22.
//

import UIKit
import SnapKit
import MapKit

enum SideMenu {
    case main
    case personalAccount
    case record
    case techCenter
    case stocks
    case notification
    case feedBack
    case chat
    case articles
    case FAQ
    case barcode
    case freeDiagnost
}

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
        tableView.horizontalScrollIndicatorInsets = .zero
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
        TechCenterAPI.techCenterList { techCenters in
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            for center in techCenters {
                let action = UIAlertAction(title: center.title, style: .default) { action in
                    print(center.latitude, center.longitude)
                    self.openMap(lat: center.latitude, lng: center.longitude, name: center.address)
                }
                alert.addAction(action)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancel)
            self.present(alert, animated: true)
            
        } failure: { error in
            print(error!.localizedDescription)
            return
        }

    }
    
    private func openMap(lat: String, lng: String, name: String) {
        let latitute: CLLocationDegrees =  Double(lat) ?? 0
        let longitute: CLLocationDegrees =  Double(lng) ?? 0

        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)

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
            if rootScreen == .main {
                dismiss(animated: true)
            } else {
                dismiss(animated: true)
                router?.pushMainVC()
            }
        case 1:
            if UserDefaultsService.sharedInstance.authToken != nil {
                
                if rootScreen == .personalAccount {
                    dismiss(animated: true)
                } else {
                    dismiss(animated: true)
                    router?.pushCabinetVC()
                }
            } else {
                dismiss(animated: true)
                router?.pushRegistrationVC()
            }
        case 2:
            if rootScreen == .record {
                dismiss(animated: true)
            } else {
                dismiss(animated: true)
                router?.pushTechnicalRecordVC()
            }
        case 3:
            if rootScreen == .techCenter {
                dismiss(animated: true)
            } else {
                dismiss(animated: true)
                router?.pushTechnicalCenterVC()
            }
        case 4:
            if rootScreen == .stocks {
                dismiss(animated: true)
            } else {
                dismiss(animated: true)
                //  router
            }
        case 5:
            if rootScreen == .notification {
                dismiss(animated: true)
            } else {
                dismiss(animated: true)
                router?.pushNotificationVC()
            }
        case 6:
            if UserDefaultsService.sharedInstance.authToken != nil {
                if rootScreen == .feedBack {
                    dismiss(animated: true)
                } else {
                    dismiss(animated: true)
                    router?.pushFeedBack()
                }
            } else {
                dismiss(animated: true)
                router?.pushRegistrationVC()
            }
            
        case 7:
            if rootScreen == .chat {
                dismiss(animated: true)
            } else {
                dismiss(animated: true)
                //  router
            }
        case 8:
            if rootScreen == .articles {
                dismiss(animated: true)
            } else {
                dismiss(animated: true)
                //  router
            }
        case 9:
            if rootScreen == .FAQ {
                dismiss(animated: true)
            } else {
                dismiss(animated: true)
                router?.pushHelpVC()
            }
        case 10:
            if rootScreen == .barcode {
                dismiss(animated: true)
            } else {
                dismiss(animated: true)
              //  router
            }
        case 11:
            if rootScreen == .freeDiagnost {
                dismiss(animated: true)
            } else {
                dismiss(animated: true)
                router?.pushMaintenanceVC()
            }
        default:
            print("__Tap__")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
}
