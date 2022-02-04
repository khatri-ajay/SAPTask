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
}
// MARK: - View Life Cycle methods
extension DashboardVC{
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}
// MARK: - ViewSetup
extension DashboardVC{
    func setup() {
        setupViews()
        setupLayouts()
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
               // print(message)
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
            print("need more images")
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
    }
}
