//
//  CarInfoNumberView.swift
//  QMotors
//
//  Created by MIrmuxammad on 10/08/22.
//

import UIKit
import SnapKit

class CarInfoNumberView: UIView {
    
    // MARK: - UI Elements
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        return view
    }()
    
    let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let rightView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let numberTitle: UILabel = {
        let label = UILabel()
        label.text = "р 070 вк"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    let regionNumber: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    let rusTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 4.5)
        label.text = "RUS"
        return label
    }()
    
    let flagImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "flag")
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
        
    private func setupViews() {
        addSubview(backView)
        backView.addSubview(leftView)
        backView.addSubview(rightView)
        leftView.addSubview(numberTitle)
        rightView.addSubview(regionNumber)
        rightView.addSubview(rusTitle)
        rightView.addSubview(flagImage)
    }
    
    private func setupConstraints() {
        
        backView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 93, height: 25))
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        leftView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(backView.snp.left).offset(2)
            make.right.equalToSuperview().offset(-25)
            make.height.equalToSuperview().offset(-4)
        }
       
        rightView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(leftView.snp.right).offset(-2)
            make.height.equalToSuperview().offset(-4)
            make.right.equalToSuperview().offset(-2)
            make.width.equalTo(backView.frame.width / 2.5)
        }
        
        numberTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        regionNumber.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-2)
            make.centerX.equalToSuperview()
        }
        
        rusTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-2)
        }
        
        flagImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 8, height: 5))
            make.right.equalToSuperview().offset(-3)
            make.bottom.equalToSuperview().offset(-3)
        }
        
    }
    
    func config(numberTitle: String, regionNumber: String) {
        setupViews()
        setupConstraints()
        self.numberTitle.text = numberTitle
        self.regionNumber.text = regionNumber
    }
    
}
