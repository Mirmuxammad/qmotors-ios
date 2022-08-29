//
//  AllFeedBacksViewController.swift
//  QMotors
//
//  Created by Александр Гужавин on 26.08.2022.
//

import UIKit
import DropDown
import SnapKit

class AllFeedBacksViewController: BaseVC {
    
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
        return button
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Все отзывы"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let technicalCenterLable: CustomLabel = {
        let label = CustomLabel(text: "Технический центр", fontWeight: .medium)
        return label
    }()
    
    private let technicalCenterField: CustomTextField = {
        let field = CustomTextField(placeholder: "Выберите из списка")
        return field
    }()
    
    private let technicalCenterButton: UIButton = UIButton()
    
    private let technicalCenterDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
    }()
    
    private let technicalCenterChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(AllFeedBacksTableViewCell.self, forCellReuseIdentifier: AllFeedBacksTableViewCell.indentity)
        tableview.separatorStyle = .none
        return tableview
    }()
    
    private var technicalCentersData = [TechnicalCenter]()
    
    private var reviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
        technicalCenterButton.addTarget(self, action: #selector(openDropDown), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        self.showLoadingIndicator()
        loadTechCenters()
    }
    

}

extension AllFeedBacksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(reviews.count)
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllFeedBacksTableViewCell.indentity) as! AllFeedBacksTableViewCell
        let review = reviews[indexPath.row]
        cell.config(review: review, serviceName: technicalCenterField.text ?? "")
        
        return cell
    }
    
    
}

// MARK: - Private actions
extension AllFeedBacksViewController {
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    @objc private func openDropDown() {
            technicalCenterDropDown.show()
            technicalCenterChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    private func loadTechCenters() {
        TechCenterAPI.techCenterList { [weak self] jsonData in
            guard let self = self else { return }
            self.technicalCentersData = jsonData
            self.setDropDowns()
            self.technicalCenterField.text = jsonData.first?.title
            self.loadReviews(centerId: jsonData.first?.id ?? 1)
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func loadReviews(centerId: Int) {
        ReviewAPI.listTechCenters(centerId: centerId) { [weak self] reviews in
            self?.reviews = reviews
            self?.tableView.reloadData()
            self?.dismissLoadingIndicator()
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    private func setDropDowns() {
        technicalCenterDropDown.dataSource = technicalCentersData.map({ i in
            i.title
        })
        technicalCenterDropDown.anchorView = technicalCenterButton
        technicalCenterDropDown.direction = .bottom
        technicalCenterDropDown.bottomOffset = CGPoint(x: 0, y:technicalCenterButton.frame.height + 10)
        technicalCenterDropDown.width = technicalCenterButton.frame.width
        technicalCenterDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.technicalCenterField.text = item
            self?.technicalCenterDropDown.hide()
            self?.technicalCenterChevronButton.transform = .identity
            self?.showLoadingIndicator()
            self?.loadReviews(centerId: self?.technicalCentersData[index].id ?? index)
        }
    }
    
    
}

// MARK: - Setup Views
extension AllFeedBacksViewController {
    
    private func addViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(tableView)
        backgroundView.addSubview(technicalCenterLable)
        backgroundView.addSubview(technicalCenterField)
        backgroundView.addSubview(technicalCenterButton)
        technicalCenterField.addSubview(technicalCenterChevronButton)
    }
    
    private func addConstraints() {
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
        }
        
        technicalCenterLable.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        technicalCenterField.snp.makeConstraints { make in
            make.top.equalTo(technicalCenterLable.snp.bottom).offset(14)
            make.height.equalTo(54)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        technicalCenterButton.snp.makeConstraints { make in
            make.edges.equalTo(technicalCenterField)
        }
        
        technicalCenterChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(technicalCenterField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

