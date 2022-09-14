//
//  ArticleDeteilViewController.swift
//  QMotors
//
//  Created by Александр Гужавин on 31.08.2022.
//

import UIKit
import SnapKit
import SDWebImage

class ArticleDeteilViewController: BaseVC {
    
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
        label.text = "Статьи"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
        scrollView.layer.cornerRadius = 5
        return scrollView
    }()
    
    private let dateTitle: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Montserrat-Regular", size: 14)
        return lable
    }()
    
    private let artecleImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "empty-photo")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let deteilTitle: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Montserrat-Regular", size: 14)
        lable.numberOfLines = 0
        return lable
    }()
    
    private let articleID: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setupAction(target: self, action: #selector(backButtonDidTap))
        loadArticle()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addViews()
        addConstraints()
    }
    
    init(id: Int) {
        self.articleID = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private actions
extension ArticleDeteilViewController {
    @objc private func backButtonDidTap() {
        router?.back()
    }
    
    private func loadArticle() {
        self.showLoadingIndicator()
        ArticleAPI.getArticle(id: articleID) { [weak self] article in
            self?.titleLable.text = article.title
            if let text = article.text {
                self?.deteilTitle.attributedText = NSAttributedString(html: text)
            }
            self?.dateTitle.text = article.created_at.getFormattedDate()
            let photoUrl = BaseAPI.baseURL + article.preview
            let url = URL(string: photoUrl)
            self?.artecleImage.sd_setImage(with: url)
            self?.dismissLoadingIndicator()
        } failure: { error in
            print(error?.localizedDescription)
            self.dismissLoadingIndicator()
        }

    }
    
}

// MARK: - Setup Constreints
extension ArticleDeteilViewController {
    private func addViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(dateTitle)
        scrollView.addSubview(artecleImage)
        scrollView.addSubview(deteilTitle)
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
            make.top.equalToSuperview().offset(20)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(backButton.snp.bottom).offset(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-8)
        }
        
        dateTitle.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(24)
        }
        
        artecleImage.snp.makeConstraints { make in
            make.top.equalTo(dateTitle.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(114)
        }
        
        deteilTitle.snp.makeConstraints { make in
            make.top.equalTo(artecleImage.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
}
