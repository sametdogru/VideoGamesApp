//
//  HomePageViewController.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import UIKit
import Alamofire

class HomePageViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerViewHeightConstant: NSLayoutConstraint!
    private var searchController: UISearchController!
    
    var searchText = String()
    let viewModel = HomePageViewModel()
    
    lazy var PageViewController: UIHomePageViewController = {
        var viewController = UIHomePageViewController.instantiate()
        viewController.gameList = viewModel.gameList
        return viewController
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        title = "Home"
        setupNavigationBar()
        collectionViewConfigure()
        gameListRequest()
    }
    
    private func setupNavigationBar(){
        self.setupSearchBar()
        navigationItem.titleView = searchController.searchBar
    }
    
    private func setupSearchBar(){
        let sc = UISearchController(searchResultsController: nil)
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchResultsUpdater = self
        sc.hidesNavigationBarDuringPresentation = false
        sc.searchBar.placeholder = "Arama"
        sc.searchBar.delegate = self
        sc.searchBar.barTintColor = UIColor.red
        UISearchBar.appearance().tintColor = .red
        self.searchController = sc
    }
    
    func gameListRequest() {
        self.viewModel.requestForGameList()
        
        self.viewModel.updateUI = {
            self.add(asChildViewController: self.PageViewController)
            self.collectionView.reloadData()
        }
        
        self.viewModel.updateUIWithError = { error in
            self.showAlert(error)
        }
    }
    
    func collectionViewConfigure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BaseCollectionViewCell.self)
    }
}

//MARK: - UISearchBarDelegate
extension HomePageViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.searchText = searchController.searchBar.text?.lowercased() ?? ""
        if searchText.count >= 3 {
            self.viewModel.isSearched = true
            let searchItem = self.viewModel.gameList.filter({(($0.name ?? "").localizedCaseInsensitiveContains(self.searchText))})
            self.viewModel.gameList = searchItem
            self.viewTransition(item: self.containerView, constant: 0)
        } else if searchText.count == 0 {
            self.viewModel.isSearched = false
            self.viewModel.gameList.removeAll()
            self.viewModel.requestForGameList()
            self.viewTransition(item: self.containerView, constant: 271)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
    }
    
    private func viewTransition(item: UIView, constant: CGFloat) {
            self.containerViewHeightConstant.constant = constant
            UIView.transition(with: item, duration: 0.7, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewModel.getItemsCount() == 0 {
            self.collectionView.setEmptyMessage("Üzgünüz, aradığınız oyun bulunamadı!")
        } else {
            self.collectionView.restore()
        }
        return self.viewModel.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : BaseCollectionViewCell = collectionView.dequeReusableCell(for: indexPath)
        cell.configure(item: self.viewModel.getItemAtIndex(indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.goToGameDetails(id: String(describing: self.viewModel.getItemAtIndex(indexPath.row).id ?? 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == ((self.viewModel.getItemsCount()) - 6) && (self.viewModel.getMoreGame) {
            self.viewModel.requestForGameList(page: true)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.viewTransition(item: self.containerView, constant: 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 {
            self.viewTransition(item: self.containerView, constant: 271)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
}

extension HomePageViewController {
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
