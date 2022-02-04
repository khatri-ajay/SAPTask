//
//  DashboardVC.swift
//  SAPTask
//
//  Created by Ajay Kumar on 02/02/2022.
//

import UIKit
import PrettyConstraints

class DashboardVC: UIViewController {
    
    var response: Main?
    var searchHistory : SearcHistoryVC = SearcHistoryVC()
    
    // MARK: - UI Object creation
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Strings.searchBarPlaceholder
        return searchBar
    }()
    private let imagesTableView : UITableView = {
        let tableview = UITableView()
        tableview.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.nameOfClass())
        tableview.backgroundColor = .white
        tableview.separatorStyle = .none
        return tableview
    }()
    private let historyView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.isHidden = true
        return view
    }()
}
// MARK: - View Life Cycle methods
extension DashboardVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
}
// MARK: - Adding UI object to view
extension DashboardVC {
    
    private func setupViews() {
        view.backgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        imagesTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imagesTableView)
        historyView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(historyView)
    }
}
// MARK: - Adding Constraints
extension DashboardVC{
    private func setupLayouts() {
        // Search Bar Constraints
        searchBar.applyConstraints(
            .top(to: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            .leading(to: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            .trailing(to: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        )
        // Table View Constraints
        imagesTableView.applyConstraints(
            .top(to: searchBar.bottomAnchor, constant: 0),
            .leading(to: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            .trailing(to: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            .bottom(to: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        )
        historyView.applyConstraints(
            .top(to: searchBar.bottomAnchor, constant: 0),
            .leading(to: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            .trailing(to: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            .height(constant: 300)
        )
        
    }
}
// MARK: - ViewSetup
extension DashboardVC{
    func setup() {
        setupViews()
        setupLayouts()
        addHistorySearchVC()
        searchBar.delegate = self
    }
    func imagesTableViewDelegate() {
        imagesTableView.delegate = self
        imagesTableView.dataSource = self
    }
    func disableTableViewFooter(){
        self.imagesTableView.tableFooterView = nil
        self.imagesTableView.tableFooterView?.isHidden = true
    }
    func addHistorySearchVC() {
        addChild(searchHistory)
        historyView.addSubview(searchHistory.view)
        searchHistory.view.frame = historyView.bounds
        searchHistory.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchHistory.didMove(toParent: self)
        searchHistory.delegate = self

    }
    func getSearchedImages(text: String,page: Int = 1) {
        weak var weakSelf = self
        let pageNumber = String(describing: page)
        ImageModel.getPhotos(text: text,page: pageNumber) { object, status, message in
            if status!{
                if page == 1{
                    weakSelf?.response = object!
                    weakSelf?.imagesTableViewDelegate()
                }else{
                    weakSelf?.response!.photos.page = object!.photos.page
                    weakSelf?.response!.photos.photo.append(contentsOf: object!.photos.photo)
                    weakSelf?.disableTableViewFooter()
                }
                weakSelf?.imagesTableView.reloadData()
            }else{
                Utility.showAlertwithOkButton(message: message!, controller: self)
            }
        }
    }
}
// MARK: - Images Table View Delegate and Data Source
extension DashboardVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (response?.photos.photo.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.nameOfClass(),for:indexPath) as! ImageTableViewCell
        cell.tag = indexPath.row
        cell.backgroundColor = UIColor.clear
        cell.setup(model: response!.photos.photo[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if response!.photos.page < response!.photos.pages{
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                let spinner = UIActivityIndicatorView(style: .medium)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                self.imagesTableView.tableFooterView = spinner
                self.imagesTableView.tableFooterView?.isHidden = false
                getSearchedImages(text: searchBar.text!, page: response!.photos.page + 1)
            }
            
        }
    }
}
// MARK: - UI Search Bar Delegate Method
extension DashboardVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        getSearchedImages(text: searchBar.text!)
        if !History.SearchHistory.contains(where: {$0 == searchBar.text!}){
            History.SearchHistory.append(searchBar.text!)
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if History.SearchHistory.count > 0 {
            historyView.isHidden = false
            searchHistory.reloadData()
        }
    }
}

// MARK: - History Keyword Selected protocol
extension DashboardVC: SearcHistoryDelegate{
    func keywordSelected(tag: Int) {
        searchBar.text = History.SearchHistory[tag]
        historyView.isHidden = true
        getSearchedImages(text: searchBar.text!)
        searchBar.resignFirstResponder()
    }
}
