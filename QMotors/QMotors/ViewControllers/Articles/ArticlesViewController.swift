//
//  ArticlesViewController.swift
//  QMotors
//
//  Created by Александр Гужавин on 31.08.2022.
//

import UIKit
import SnapKit

// MARK: - UI
class ArticlesViewController: BaseVC {
    
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
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(ArticlesTableViewCell.self, forCellReuseIdentifier: ArticlesTableViewCell.identifier)
        return tableView
    }()
    
    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setupAction(target: self, action: #selector(backButtonDidTap))
        tableView.delegate = self
        tableView.dataSource = self
        addViews()
        addConstraints()
        loadArticles()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addViews()
        addConstraints()
    }
    
    override func leftMenuButtonDidTap() {
        sideMenuVC.rootScreen = .articles
        super.leftMenuButtonDidTap()
    }

}

// MARK: - Private actions
extension ArticlesViewController {
    @objc private func backButtonDidTap() {
        router?.back()
    }
    
    private func loadArticles() {
        self.showLoadingIndicator()
        ArticleAPI.getArticles { [weak self] articles in
            self?.articles = articles
            self?.tableView.reloadData()
            self?.dismissLoadingIndicator()
        } failure: { error in
            print(error?.localizedDescription)
            self.dismissLoadingIndicator()
        }
    }
    
}

// MARK: - TableView delegate
extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticlesTableViewCell.identifier) as! ArticlesTableViewCell
        cell.selectionStyle = .none
        let article = articles[indexPath.row]
        let photoUrl = BaseAPI.baseURL + article.preview
        let url = URL(string: photoUrl)
        cell.setView(title: article.title,
                     date: article.created_at.getFormattedDate(),
                     deteil: article.subtitle,
                     imageURL: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        router?.pushArticleDeteil(id: article.id)
    }
}

// MARK: - Setup Constreints

extension ArticlesViewController {
    private func addViews() {
        view.addSubview(logoImageView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(tableView)
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
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
