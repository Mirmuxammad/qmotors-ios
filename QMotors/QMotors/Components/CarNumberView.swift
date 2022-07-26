//
//  CarNumberView.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 24.07.22.
//

import UIKit
import SnapKit

class CarNumberView: UIView {
    
    // MARK: - UI Elements
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let rightView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let numberTitle: UILabel = {
        let label = UILabel()
        label.text = "р 070 вк"
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    let regionTitle: UILabel = {
        let label = UILabel()
        label.text = "92"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    let downTitle: UILabel = {
        let label = UILabel()
        label.text = "RUS"
        return label
    }()
    
    let flagView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 3
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let blueFlagColor: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let redFlagColor: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
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
        leftView.addSubview(regionTitle)
        leftView.addSubview(downTitle)
        leftView.addSubview(flagView)
        flagView.addSubview(blueFlagColor)
        flagView.addSubview(redFlagColor)
    }
    
    private func setupConstraints() {
        
        let height = (self.frame.width - 32) / 5
        
        backView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(height)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        leftView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(2)
            make.right.equalToSuperview().offset(-2)
            make.height.equalToSuperview().offset(-4)
        }
        rightView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-(height * 1.3))
            make.width.equalTo(2)
            make.height.equalToSuperview().offset(-3)
        }
        numberTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalTo(rightView.snp.left).offset(-10)
        }
        regionTitle.snp.makeConstraints { make in
            make.left.equalTo(rightView.snp.right).offset(10)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-(height * 0.37))
            make.right.equalToSuperview().offset(-10)
        }
        downTitle.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-4)
            make.left.equalTo(rightView.snp.right).offset(4)
            make.height.equalTo(height * 0.3)
            make.right.equalTo(flagView.snp.left).offset(-2)
        }
        
        flagView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-4)
            make.right.equalToSuperview().offset(-4)
            make.height.equalTo(height * 0.3)
            make.width.equalTo(height * 0.5)
        }
        
        blueFlagColor.snp.makeConstraints { make in
            make.height.equalTo(height * 0.1)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-1)
        }
        redFlagColor.snp.makeConstraints { make in
            make.height.equalTo(height * 0.1)
            make.top.equalTo(blueFlagColor.snp.bottom)
            make.left.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-1)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Public functions
    
    func config(numberTitle: String, regionTitle: String) {
        setupViews()
        setupConstraints()
        self.numberTitle.text = numberTitle
        self.regionTitle.text = regionTitle
    }
}
