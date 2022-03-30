//
//  MainVC.swift
//  MVC-NasaRovers
//
//  Created by Hasan Dag on 24.03.2022.
//

import UIKit

protocol ViewControllerProtocol:AnyObject {
    func getNewsModel(model:NewsModel)
}

final class MainVC:UIViewController {
    // MARK:-Properties
    private var searchWorkItem: DispatchWorkItem?
    var presenter : PresenterDelegate?
    var page:Int = 1
    var model : [News] = []
    // MARK:-View Elements
    private lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Any News"
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.searchBarStyle = .prominent
        return searchBar
    }()

    private lazy var tableView : UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = true
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter = Presenter(view: self)
        presenter?.getNews(keyword: nil, page: page)
    }
    
    fileprivate func configureUI(){
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        navigationItem.titleView = searchBar
        view.addSubview(tableView)
        searchBar.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().inset(UIView.width * 0.1)
            maker.bottom.top.equalToSuperview()
            maker.trailing.equalToSuperview().inset(UIView.width * 0.2)
        }
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        view.backgroundColor = UIColor(named: "viewBg")
    }
    
    @objc func refresh(_ sender:UIRefreshControl){
        searchBar.text = ""
        presenter?.getNews(keyword: nil, page: page)
        sender.endRefreshing()
    }
}

extension MainVC : ViewControllerProtocol {
    func getNewsModel(model: NewsModel) {
        // alınan modeli view e göndermeli
        print("model triggerlandı")
        print(model.articles.count ?? 0)
        self.model = model.articles
        DispatchQueue.main.async {
            self.page == 1 ? self.tableView.reloadData() : self.tableView.reloadRows(at: [IndexPath(row: 0, section: self.model.count)], with: .fade)
        }
    }
}

// MARK:- Searchbar Delegate
extension MainVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchWorkItem?.cancel()
        let requestWorkItem = DispatchWorkItem { [weak self] in
            self?.presenter?.getNews(keyword: searchText, page: self?.page)
        }
        
        searchWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800), execute: requestWorkItem)
    }
}
// MARK:- TableView Delegate

extension MainVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
         
        cell.textLabel?.text = model[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(UIView.height * 0.2)
    }
    
    
}
