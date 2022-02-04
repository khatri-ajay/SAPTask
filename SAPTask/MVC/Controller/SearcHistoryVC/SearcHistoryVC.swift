//
//  SearcHistoryVC.swift
//  SAPTask
//
//  Created by Ajay Kumar on 04/02/2022.
//

import UIKit

protocol SearcHistoryDelegate: AnyObject {
    func keywordSelected(tag: Int)
}

class SearcHistoryVC: UIViewController {
    weak var delegate : SearcHistoryDelegate?
    
    private let historyTableView : UITableView = {
        let tableview = UITableView()
        tableview.register(LabelTableViewCell.self, forCellReuseIdentifier: LabelTableViewCell.nameOfClass())
        tableview.backgroundColor = .white
        tableview.separatorStyle = .singleLine
        return tableview
    }()
}
// MARK: - View Life Cycle methods
extension SearcHistoryVC{
    override func viewDidLoad() {
        super.viewDidLoad()
               setup()
    }
}
// MARK: - Adding UI object to view
extension SearcHistoryVC {
    
    private func setupViews() {
        view.backgroundColor = .white
        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(historyTableView)
    }
}
// MARK: - Adding Constraints
extension SearcHistoryVC{
    private func setupLayouts() {
        // Table View Constraints
        historyTableView.applyConstraints(
            .top(to: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            .leading(to: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            .trailing(to: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            .bottom(to: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        )
    }
}
// MARK: - ViewSetup
extension SearcHistoryVC{
    func setup() {
        setupViews()
        setupLayouts()
        imagesTableViewDelegate()
    }
    func imagesTableViewDelegate() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    func reloadData() {
        historyTableView.reloadData()
    }
}
// MARK: - Images Table View Delegate and Data Source
extension SearcHistoryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return History.SearchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.nameOfClass(),for:indexPath) as! LabelTableViewCell
        cell.tag = indexPath.row
        cell.backgroundColor = UIColor.clear
        cell.setup(text: History.SearchHistory[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.keywordSelected(tag: indexPath.row)
        }
    }
  
}
