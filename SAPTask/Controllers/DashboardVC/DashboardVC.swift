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
    private let imagesCollectionView : UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        // Do any additional setup after loading the view.
    }

}
extension DashboardVC {
    // MARK: - Adding UI object to view
    private func setupViews() {
        view.backgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imagesCollectionView)
    }
}
extension DashboardVC{
    // MARK: - Adding Constraints
    private func setupLayouts() {
        // Search Bar Constraints
        searchBar.applyConstraints(
            .top(to: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            .leading(to: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            .trailing(to: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        )
        // Collection View Constraints
        imagesCollectionView.applyConstraints(
            .top(to: searchBar.bottomAnchor, constant: 0),
            .leading(to: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            .trailing(to: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            .bottom(to: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        )
    }
}
