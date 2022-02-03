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
//        searchBar.returnKeyType = .search
        return searchBar
    }()
    private let imagesCollectionView : UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.nameOfClass())
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
        searchBar.delegate = self
    }
    func imagesCollectionViewDelegate() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
    }
    func getSearchedImages(text: String) {
        weak var weakSelf = self
        ImageModel.getPhotos(text: text) { object, status, message in
            if status!{
                weakSelf?.response = object!
                weakSelf?.imagesCollectionViewDelegate()
                weakSelf?.imagesCollectionView.reloadData()
            }else{
               // print(message)
            }
        }
    }
}
// MARK: - Images Collection View Delegate, Data Source and FlowLayout method
extension DashboardVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: (self.view.frame.width/2) - 10 , height:  120 )
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (response?.photos.photo.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.nameOfClass(),for:indexPath) as! ImageCollectionViewCell
        cell.tag = indexPath.row
        cell.backgroundColor = UIColor.clear
        cell.setup(model: response!.photos.photo[indexPath.row])
        return cell
    }
}
// MARK: - UI Search Bar Delegate Method
extension DashboardVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        getSearchedImages(text: searchBar.text!)
    }
}
