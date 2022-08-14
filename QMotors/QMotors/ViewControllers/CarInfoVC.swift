//
//  CarInfoVC.swift
//  QMotors
//
//  Created by MIrmuxammad on 08/08/22.
//

import UIKit
import SnapKit
import SDWebImage

class CarInfoVC: BaseVC {
    
    // MARK: - Properties
    
    var car: MyCarModel? {
        didSet {
            guard let car = car, let intMileage = Int(car.mileage) else { return }
            if let carPhotos = car.user_car_photos {
                carPhotos.forEach({
                    carImageView.sd_setImage(with: URL(string: BaseAPI.baseURL + $0.photo), placeholderImage: nil)
                })
            }
            carModelLabel.text = car.model
            millageLabel.text = "\(intMileage.formattedWithSeparator) км"
            lastVisitLabel.text = car.last_visit.getDateString()
            VINLabel.text = car.vin
            carId = car.id
            carYear = car.year
            carNumberView.numberTitle.text = car.number.getCarNumber()
            carNumberView.regionNumber.text = car.number.getCarRegionNumber()
        }
    }
    // MARK: - Properties
    
    private var carId: Int?
    private var carYear: Int?
    private var openEditCar: Bool = false
    
    //MARK: -UI Elements-
    
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
    
    private let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "empty-photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let carModelLabel: UILabel = {
        let label = UILabel()
//        label.text = "Subaru"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let carNumberView: CarInfoNumberView = {
        let view = CarInfoNumberView()
        return view
    }()
    
    private let millageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Пробег:"
        return label
    }()
    
    private let millageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        label.textColor = .black
        label.textAlignment = .left
//        label.text = "3434324"
        return label
    }()
    
    private let lastVisitTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Последний визит:"
        return label
    }()
    
    private let lastVisitLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        label.textColor = .black
        label.textAlignment = .left
//        label.text = "22.05.2022"
        return label
    }()
    
    private let VINTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "VIN код:"
        return label
    }()
    
    private let VINLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        label.textColor = .black
        label.textAlignment = .left
//        label.text = "349179834712470"
        return label
    }()
    
    private let editCarButton: ActionButton = {
        let button = ActionButton()
        button.setupButton(target: self, action: #selector(editCarButtonDidTap))
        button.setupTitle(title: "Редактировать")
        button.isEnabled()
        return button
    }()
    
    private let trashCarButton: DeleteButton = {
        let button = DeleteButton()
        button.setupButton(target: self, action: #selector(trashCarButtonDidTap))
        return button
    }()
    
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if openEditCar {
            self.router?.back()
            openEditCar = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Private functions -
    
    
    private func setupView() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(carImageView)
        backgroundView.addSubview(carModelLabel)
        
        carImageView.addSubview(carNumberView)
        
        backgroundView.addSubview(millageTitleLabel)
        backgroundView.addSubview(millageLabel)
        
        backgroundView.addSubview(lastVisitTitleLabel)
        backgroundView.addSubview(lastVisitLabel)
        
        backgroundView.addSubview(VINTitleLabel)
        backgroundView.addSubview(VINLabel)
        
        backgroundView.addSubview(editCarButton)
        backgroundView.addSubview(trashCarButton)
        
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
        
        carImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: (self.view.frame.width - 32), height: (self.view.frame.width / 3)))
            make.top.equalTo(backButton.snp.bottom).offset(17)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        carNumberView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().offset(-19)
        }
        
        carModelLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(carImageView.snp.bottom).offset(19)
        }
        
        millageTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(carModelLabel.snp.bottom).offset(18)
        }
        
        millageLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(millageTitleLabel.snp.bottom)
        }
        
        lastVisitTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(millageLabel.snp.bottom).offset(16)
        }
        
        lastVisitLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(lastVisitTitleLabel.snp.bottom)
        }
        
        VINTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(lastVisitLabel.snp.bottom).offset(16)
        }
        
        VINLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(VINTitleLabel.snp.bottom)
        }
        
        editCarButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-107)
            make.top.equalTo(VINLabel.snp.bottom).offset(19)
            make.height.equalTo(55)
        }
        
        trashCarButton.snp.makeConstraints { make in
            make.left.equalTo(editCarButton.snp.right).offset(17)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(VINLabel.snp.bottom).offset(19)
            make.height.equalTo(55)
        }
        
    }
    
    //MARK: -Private Action-
    
    
    @objc private func backButtonDidTap() {
        router?.back()
    }
    
    @objc private func editCarButtonDidTap() {
        if let car = car {
            router?.pushCarVCForEdit(car: car)
            openEditCar = true
        }
    }
    
    @objc private func trashCarButtonDidTap() {
        
        guard let carid = carId else { return }
        
        CarAPI.deleteCar(carId: carid, status: .deleted, success: { [weak self] result in
            self?.router?.back()
        }) { [weak self] error in
            print(error)
        }
    }
    
}
