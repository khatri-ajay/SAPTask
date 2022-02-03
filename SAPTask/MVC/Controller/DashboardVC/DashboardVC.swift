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
        searchBar.placeholder = Strings.searchBarPlaceholder
        searchBar.returnKeyType = .search
        return searchBar
    }()
    private let imagesCollectionView : UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
}
// MARK: - View Life Cycle methods
extension DashboardVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
}
// MARK: - Adding UI object to view
extension DashboardVC {
    
    private func setupViews() {
        view.backgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imagesCollectionView)
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
        // Collection View Constraints
        imagesCollectionView.applyConstraints(
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
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
    }
}
// MARK: - Images Collection View Delegate, Data Source and FlowLayout method
extension DashboardVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //let size1 = (contentArray[indexPath.row] as String).size(withAttributes: nil)
        return CGSize(width: (self.view.frame.width/2) - 10 , height:  120 )
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.nameOfClass(),for:indexPath) as! ImageCollectionViewCell
        cell.tag = indexPath.row
        cell.backgroundColor = UIColor.clear
        cell.setup(model: ImageModel())
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        return cell
    }
    
    
}
