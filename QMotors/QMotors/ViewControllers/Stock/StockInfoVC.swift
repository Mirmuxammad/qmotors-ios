//
//  StockInfoVC.swift
//  QMotors
//
//  Created by MIrmuxammad on 06/09/22.
//

import UIKit
import SnapKit

class StockInfoVC: BaseVC {

    // MARK: - Properties
    
    var stock: Stock? {
        didSet {
            stockTitle.text = stock?.title
            subTitleLabel.text = stock?.subtitle
            if stock?.location == nil {
                locationTitleLabel.isHidden = true
                locationImageView.isHidden = true
            } else {
                locationTitleLabel.isHidden = false
                locationImageView.isHidden = false
                locationTitleLabel.text = stock?.location
            }
            stockTextLabel.text = stock?.text?.htmlToString
        }
    }
        
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
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#9CC55A")
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let stockTitle: UILabel = {
         let label = UILabel()
         label.font = UIFont(name: Const.fontBold, size: 20)
         label.textColor = .white
         label.textAlignment = .left
         label.text = "Подробности акции, здесь краткое описание ации"
         label.numberOfLines = 0
         return label
    }()
    
    private let subTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MapPinLine_Black")
        imageView.tintColor = .black
        return imageView
    }()
        
    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontMed, size: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    
    private let stockTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.fontReg, size: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let sendStockButton: ActionButton = {
        let button = ActionButton()
        button.setupTitle(title: "ЗАКАЗАТЬ АКЦИЮ")
        button.setupButton(target: self, action: #selector(addSendButtonTapped))
        button.isEnabled()
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stockTitle)
        contentView.addSubview(subTitleLabel)
        scrollView.addSubview(locationImageView)
        scrollView.addSubview(locationTitleLabel)
        scrollView.addSubview(stockTextLabel)
        backgroundView.addSubview(sendStockButton)
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
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(100)
            make.width.equalTo(UIScreen.main.bounds.width-40)
        }
        
        stockTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(24)
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-10)
            make.right.equalToSuperview().offset(-24)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(stockTitle.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 35, height: 35))
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(contentView.snp.bottom).offset(16)
        }
        
        locationTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationImageView.snp.centerY)
            make.left.equalTo(locationImageView.snp.right).offset(16)
            make.height.equalTo(14)
        }
        if stock?.location == nil {
            stockTextLabel.snp.makeConstraints { make in
                make.top.equalTo(contentView.snp.bottom).offset(16)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.bottom.equalToSuperview()
            }
        } else {
            stockTextLabel.snp.makeConstraints { make in
                make.top.equalTo(locationImageView.snp.bottom).offset(16)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.bottom.equalToSuperview()
            }
        }
        sendStockButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonDidTap() {
        print("backButtonDidTap")
        router?.back()
    }
    
    @objc private func addSendButtonTapped() {
        guard let stock = stock else { return }
        router?.pushAddStockVC(stock: stock)
    }
}
