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
    
    let numberTitle: UILabel = {
        let label = UILabel()
        label.text = "р 070 вк"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        
        return label
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
        leftView.addSubview(numberTitle)
    }
    
    private func setupConstraints() {
        
        backView.snp.makeConstraints { make in
           // make.centerY.equalToSuperview()
           // make.centerX.equalToSuperview()
        }
        leftView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(2)
            make.right.equalToSuperview().offset(-2)
            make.height.equalToSuperview().offset(-4)
        }
       
        numberTitle.snp.makeConstraints { make in
            make.left.equalTo(backView.snp.left).offset(10)
            make.right.equalTo(backView.snp.right).offset(-10)
            make.top.equalTo(backView.snp.top).offset(5)
            make.bottom.equalTo(backView.snp.bottom).offset(-5)
        }
    }
    
    func config(numberTitle: String) {
        setupViews()
        setupConstraints()
        self.numberTitle.text = numberTitle
    }
    
}
