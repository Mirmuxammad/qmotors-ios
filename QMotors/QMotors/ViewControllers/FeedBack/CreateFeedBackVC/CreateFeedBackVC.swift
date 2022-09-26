//
//  FeedbackVC.swift
//  QMotors
//
//  Created by Mavlon on 29/08/22.
//

import UIKit
import DropDown
import SnapKit

class CreateFeedBackVC: BaseVC {
    
    // MARK: - Properties
    
    private var selectedRating = 0
    private var myCars: [MyCarModel] = []
    private var myOrders: [Order] = []
    private var orderID: Int?

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
        label.text = "Оставить отзыв"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = Const.fieldBorderColor.cgColor
        return view
    }()
    
    private let starLabel: UILabel = {
        let label = UILabel()
        label.text = "Поставьте оценку"
        label.font = UIFont(name: Const.fontMed, size: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo-stars")
        return imageView
    }()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    private let star1: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setImage(UIImage(named: "star.empty"), for: .normal)
        button.addTarget(self, action: #selector(starButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private let star2: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.setImage(UIImage(named: "star.empty"), for: .normal)
        button.addTarget(self, action: #selector(starButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private let star3: UIButton = {
        let button = UIButton()
        button.tag = 3
        button.setImage(UIImage(named: "star.empty"), for: .normal)
        button.addTarget(self, action: #selector(starButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private let star4: UIButton = {
        let button = UIButton()
        button.tag = 4
        button.setImage(UIImage(named: "star.empty"), for: .normal)
        button.addTarget(self, action: #selector(starButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private let star5: UIButton = {
        let button = UIButton()
        button.tag = 5
        button.setImage(UIImage(named: "star.empty"), for: .normal)
        button.addTarget(self, action: #selector(starButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let scrollContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let feedBackLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш отзыв"
        label.font = UIFont(name: Const.fontMed, size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let textContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = Const.fieldBorderColor.cgColor
        return view
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: Const.fontReg, size: 16)
//        textView.textColor = UIColor(hex: "595959")
        textView.text = "Опишите ваши замечания по заказ наряду"
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    private let carLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш автомобиль"
        label.font = UIFont(name: Const.fontMed, size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let carField: CustomTextField = {
        let field = CustomTextField(placeholder: "Выберите из списка")
        return field
    }()
    
    private let carButton: UIButton = UIButton()
    
    private let carDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
    }()
    
    private let carChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
        return button
    }()
    
    private let orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Заказ - наряд"
        label.font = UIFont(name: Const.fontMed, size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let orderField: CustomTextField = {
        let field = CustomTextField(placeholder: "Выберите из списка")
        return field
    }()
    
    private let orderButton: UIButton = UIButton()
    
    private let orderDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor(hex: "B6B6B6").cgColor
        dropDown.layer.cornerRadius = 8
        return dropDown
    }()
    
    private let orderChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevron-icon"), for: .normal)
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "9CC55A")
        button.layer.cornerRadius = 5
        button.setTitle("Отправить", for: .normal)
        button.titleLabel?.font = UIFont(name: Const.fontSemi, size: 14)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        
        textView.delegate = self
        
        carButton.addTarget(self, action: #selector(openDropDown), for: .touchUpInside)
        orderButton.addTarget(self, action: #selector(orderOpenDropDown), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendButtonDidTap), for: .touchUpInside)
        
        loadCars()
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
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        scrollContainer.addSubview(containerView)
        containerView.addSubview(starLabel)
        containerView.addSubview(logoImage)
        containerView.addSubview(starStackView)
        starStackView.addArrangedSubview(star1)
        starStackView.addArrangedSubview(star2)
        starStackView.addArrangedSubview(star3)
        starStackView.addArrangedSubview(star4)
        starStackView.addArrangedSubview(star5)
        scrollContainer.addSubview(feedBackLabel)
        scrollContainer.addSubview(textContainerView)
        textContainerView.addSubview(textView)
        scrollContainer.addSubview(carLabel)
        scrollContainer.addSubview(carField)
        scrollContainer.addSubview(carButton)
        scrollContainer.addSubview(orderLabel)
        scrollContainer.addSubview(orderField)
        scrollContainer.addSubview(orderButton)
        scrollContainer.addSubview(sendButton)
        
        carField.addSubview(carChevronButton)
        orderField.addSubview(orderChevronButton)
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
            make.height.equalTo(24)
            
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()//.offset(-24)
        }
        
        scrollContainer.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.width.equalTo(self.view.frame.width - 32)
        }
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(178)
            make.top.left.right.equalToSuperview()
        }
        
        feedBackLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(containerView.snp.bottom).offset(24)
        }
        
        textContainerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(112)
            make.top.equalTo(feedBackLabel.snp.bottom).offset(14)
        }
        
        textView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        carLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(textContainerView.snp.bottom).offset(24)
        }
        
        carField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(55)
            make.top.equalTo(carLabel.snp.bottom).offset(14)
        }
        
        carButton.snp.makeConstraints { make in
            make.edges.equalTo(carField)
        }
        
        orderLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(carField.snp.bottom).offset(24)
        }
        
        orderField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(55)
            make.top.equalTo(orderLabel.snp.bottom).offset(14)
        }
        
        orderButton.snp.makeConstraints { make in
            make.edges.equalTo(orderField)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(orderField.snp.bottom).offset(24)
            make.right.left.equalToSuperview()
            make.height.equalTo(55)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        starLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.centerX.equalToSuperview()
            make.top.equalTo(starLabel.snp.bottom).offset(11)
        }
        
        starStackView.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
        
        [star1,star2,star3,star4,star5].forEach { btn in
            btn.snp.makeConstraints { make in
                make.width.height.equalTo(36)
            }
        }
        
        carChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        
        orderChevronButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        
        
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func sendButtonDidTap() {
        guard let id = orderID, let text = textView.text else {
            let alert = UIAlertController(title: "Заполните все поля", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if text == "" || selectedRating == 0 {
            let alert = UIAlertController(title: "Заполните все поля", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            rateOrder(text: text, rating: selectedRating, id: id)
        }
    }
    
    @objc private func openDropDown() {
            carDropDown.show()
            carChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    @objc private func orderOpenDropDown() {
            orderDropDown.show()
            orderChevronButton.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    @objc private func starButtonDidTap(_ sender: UIButton) {
        
        selectedRating = sender.tag
        
        for (index, button) in [star1,star2,star3,star4,star5].enumerated() {
            UIView.animate(withDuration: 0.2) { [self] in
                button.setImage(getStarImage(starNumber: index + 1, forRating: sender.tag), for: .normal)
                button.transform = CGAffineTransform(scaleX: 1.1, y: 1)
            } completion: { _ in
                button.transform = .identity
            }
        }
    }
    
    private func rateOrder(text: String, rating: Int, id: Int) {
        
        ReviewAPI.rateOrder(orderID: id, comment: text, rating: rating) {
            let alert = UIAlertController(title: "Благодарим вас за оставленный отзыв!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.router?.back()
            }))
//            self.dismissLoadingIndicator()
            self.present(alert, animated: true, completion: nil)
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
            self.present(alert, animated: true, completion: nil)
        }

        
    }
    
    private func getStarImage(starNumber: Int, forRating rating: Int) -> UIImage {
        if rating >= starNumber {
            return UIImage(named: "star.fill")!
        } else {
            return UIImage(named: "star.empty")!
        }
    }
    
    private func loadCars() {
        CarAPI.getMyCars { cars in
            self.myCars = cars
            self.setCarDropDowns()
//            self.carField.text = cars.first?.model
            self.loadOrders(id: cars.first?.id ?? 0)
        } failure: { error in
//            print(error.debugDescription)
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
//            self.dismissLoadingIndicator()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func loadOrders(id: Int) {
        OrderAPI.orderList(userCarId: id) { responce in
            self.myOrders = []
            if let carOrder = responce.result.first {
                self.myOrders = carOrder.orders
                if carOrder.orders.isEmpty {
                    let alert = UIAlertController(title: "Не найдены наряды", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    }))
        //            self.dismissLoadingIndicator()
                    self.present(alert, animated: true, completion: nil)
                    self.setOrderDropDowns()
                } else {
                    self.setOrderDropDowns()
                }
            } else {
                let alert = UIAlertController(title: "Не найдены наряды", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                }))
    //            self.dismissLoadingIndicator()
                self.present(alert, animated: true, completion: nil)
                self.setOrderDropDowns()
                self.orderChevronButton.transform = .identity
            }
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            }))
//            self.dismissLoadingIndicator()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setCarDropDowns() {
        carDropDown.dataSource = myCars.map({ i in
            i.model
        })
        carDropDown.anchorView = carButton
        carDropDown.direction = .bottom
        carDropDown.bottomOffset = CGPoint(x: 0, y:carButton.frame.height + 10)
        carDropDown.width = carButton.frame.width
        carDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.carField.text = item
            self?.carDropDown.hide()
            self?.carChevronButton.transform = .identity
//            self?.showLoadingIndicator()
            self?.myOrders = []
            self?.orderField.text = nil
            self?.loadOrders(id: self?.myCars[index].id ?? 0)
            self?.orderID = nil
        }
    }
    
    private func setOrderDropDowns() {
        orderDropDown.dataSource = myOrders.map({ i in
            "\(i.id)" + " от " + i.date.prefix(10)
        })
        orderDropDown.anchorView = orderButton
        orderDropDown.direction = .bottom
        orderDropDown.bottomOffset = CGPoint(x: 0, y: orderButton.frame.height + 10)
        orderDropDown.width = orderButton.frame.width
        orderDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.orderField.text = item
            self?.orderID = self?.myOrders[index].id
            self?.orderDropDown.hide()
            self?.orderChevronButton.transform = .identity
//            self?.showLoadingIndicator()
//            self?.loadOrders(id: self?.myCars[index].id ?? 0)
        }
    }

}

// MARK: - UITextViewDelegate
extension CreateFeedBackVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor(hex: "595959")
            }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
                textView.text = "Опишите ваши замечания по заказ наряду"
                textView.textColor = UIColor.lightGray
            }
    }
}
