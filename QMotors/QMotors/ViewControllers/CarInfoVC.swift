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
                self.carPhotos = carPhotos
            }
            carModelLabel.text = car.model
            millageLabel.text = "\(intMileage.formattedWithSeparator) км"

            if car.last_visit == "" {
                lastVisitLabel.text = "Визита не было"
            } else if let lastVisit = car.last_visit, lastVisit != "" {
                lastVisitLabel.text = lastVisit.getFormattedDate()
            }
            VINLabel.text = car.vin
            carId = car.id
            carYear = car.year
            carNumber = car.number
            carImageSlider.reloadData()
        }
    }
    
    private var carNumber: String?
    private var carId: Int?
    private var carYear: Int?
    private var carPhotos: [CarPhoto]?
    
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
    
    private let carImageSlider: UICollectionView = {
        let slider = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        slider.setCollectionViewLayout(layout, animated: true)
        slider.showsVerticalScrollIndicator = false
        slider.showsHorizontalScrollIndicator = false
        slider.isPagingEnabled = true
        slider.register(CarInfoCollectionViewCell.self, forCellWithReuseIdentifier: CarInfoCollectionViewCell.cellIdentifier)
        return slider
    }()
    
    private let carModelLabel: UILabel = {
        let label = UILabel()
//        label.text = "Subaru"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
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
        loadInfoCar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    init(carId: Int) {
        self.carId = carId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions -
    
    private func loadInfoCar() {
        guard let carId = carId else {
            return
        }
        CarAPI.getMyCar(id: carId) { [weak self] car in
            self?.car = car
        } failure: { error in
            print(error)
        }
    }
    
    private func setupView() {
        carImageSlider.delegate = self
        carImageSlider.dataSource = self
        
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(carImageSlider)
        backgroundView.addSubview(carModelLabel)
        
        backgroundView.addSubview(millageTitleLabel)
        backgroundView.addSubview(millageLabel)
        
        backgroundView.addSubview(lastVisitTitleLabel)
        backgroundView.addSubview(lastVisitLabel)
        
        backgroundView.addSubview(VINTitleLabel)
        backgroundView.addSubview(VINLabel)
        
        backgroundView.addSubview(editCarButton)
        backgroundView.addSubview(trashCarButton)
        
    }
    
}

// MARK: -
extension CarInfoVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let carPhotos = carPhotos else { return 1 }
        
        if !carPhotos.isEmpty { return carPhotos.count }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarInfoCollectionViewCell.cellIdentifier, for: indexPath) as! CarInfoCollectionViewCell
        if let carPhotos = self.carPhotos,
           !carPhotos.isEmpty {
            cell.sliderImage = URL(string: BaseAPI.baseURL + "\(carPhotos[indexPath.item].photo)")
        }
        
        if let carNumber = carNumber {
            cell.setupCells(number: carNumber)
        }
        
        return cell
    }
    
    
}

extension CarInfoVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: carImageSlider.frame.width, height: carImageSlider.frame.height)
    }
}

// MARK: - Constraints
extension CarInfoVC {
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
        
        carImageSlider.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: (self.view.frame.width - 32), height: (self.view.frame.width / 3)))
            make.top.equalTo(backButton.snp.bottom).offset(17)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        carModelLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(carImageSlider.snp.bottom).offset(19)
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
        }
    }
    
    @objc private func trashCarButtonDidTap() {
        
        let alert = UIAlertController(title: "Вы уверены?", message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .default) { action in
            guard let carid = self.carId else { return }
            guard let car = self.car else {return}
            CarAPI.editCar(carId: carid, carModelId: car.car_model_id, year: car.year, mileage: Int(car.mileage) ?? 0, number: car.number, vin: car.vin, lastVisit: nil, status: CarStatus.deleted ) {  [weak self] result in
                    self?.router?.back()

            } failure: { [weak self] error in
                print(error?.localizedDescription)
                self?.router?.back()
            }
        }
        
        let sellAction = UIAlertAction(title: "Продать", style: .default) { action in
            guard let carid = self.carId else { return }
            guard let car = self.car else {return}
            CarAPI.editCar(carId: carid, carModelId: car.car_model_id, year: car.year, mileage: Int(car.mileage) ?? 0, number: car.number, vin: car.vin, lastVisit:Date() , status: CarStatus.sold ) {  [weak self] result in
                    self?.router?.back()

            } failure: { [weak self] error in
                print(error?.localizedDescription)
                self?.router?.back()
            }
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(sellAction)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }

}

