//
//  DashboardVC.swift
//  SAPTask
//
//  Created by Ajay Kumar on 02/02/2022.
//

import UIKit
import PrettyConstraints

class DashboardVC: UIViewController {
    
    // MARK: - UI Object creation
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    private let imagesTableView: UITableView = {
        let tableview = UITableView()
//        tableview.register(MovieTableViewCell.self, forCellReuseIdentifier: cellIdentifier.MovieTableViewCell)
        tableview.backgroundColor = .white
        tableview.separatorStyle = .none
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
extension DashboardVC {
    // MARK: - Adding UI object to view
    private func setupViews() {
        view.backgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        imagesTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imagesTableView)
    }
}
