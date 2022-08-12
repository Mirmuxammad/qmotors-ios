//
//  MyCarsVC.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 22.07.22.
//

import UIKit
import SnapKit

class MyCarsVC: BaseVC {
    
    // MARK: - Properties
    
    var myCar = [MyCarModel]()
    
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
    
    private let segmentedControl: UISegmentedControl = {
        let items = ["Мои автомобили", "Архив автомобилей"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = UIColor.init(hex: "#5A80C0")
        control.addTarget(self, action: #selector(handleSegmentedControlValueChanged(_:)), for: .valueChanged)
        return control
    }()

    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Мои автомобили"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
//        tableView.backgroundColor = .gray
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        
        tableView.register(MyCarsTableViewCell.self, forCellReuseIdentifier: MyCarsTableViewCell.identifier)
        return tableView
    }()
    
    private let addCarButton: ActionButton = {
        let button = ActionButton()
        button.setupButton(target: self, action: #selector(addCarButtonDidTap))
        button.setupTitle(title: "ДОБАВИТЬ АВТОМОБИЛЬ")
        button.isEnabled()
        return button
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
        loadMyCar()
        setupViews()
        setupConstraints()

        setupSegmentedControl()
        

    }
        
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(segmentedControl)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(tableView)
        
        
        backgroundView.addSubview(addCarButton)

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
        
        segmentedControl.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(backButton.snp.bottom).offset(15)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.height.equalTo(22)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(addCarButton.snp.top).offset(-20)
        }
        
        addCarButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
    }
    
    private func setupSegmentedControl() {
        guard let font = UIFont(name: "Montserrat-Regular", size: 14) else { return }
        
        segmentedControl.setTitleColor(.white, state: .selected)
        segmentedControl.setTitleColor(.black, state: .disabled)
        segmentedControl.setTitleFont(font)
    }
    
    private func hideAddCarButton() {
        addCarButton.isHidden = true
        
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        
    }
    
    private func showAddCarButton() {
        addCarButton.isHidden = false
        
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(addCarButton.snp.top).offset(-20)
        }
        
        addCarButton.snp.remakeConstraints { make in
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
    }
    
    //MARK: - Load My Car -
    
    func loadMyCar() {
        activityIndicator.startAnimating()
        CarAPI.getMyCarModel { [weak self] jsonData in
            guard let self = self else { return }
            self.myCar = jsonData
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
    
    @objc private func handleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            showAddCarButton()
        case 1:
            hideAddCarButton()
        default:
            print("Segment is out of range")
        }
    }
    
    @objc private func addCarButtonDidTap() {
        print(#function)
        router?.pushCarVC()
    }

}

// MARK: - UITableViewDataSource
extension MyCarsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myCar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: MyCarsTableViewCell.identifier, for: indexPath) as? MyCarsTableViewCell
        else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setupCell(myCar[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}

// MARK: - UITableViewDelegate
extension MyCarsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt - \(indexPath.row)")
        router?.pushCarInfoVC(car: myCar[indexPath.row])
    }
}
