//
//  FavoritesViewController.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import UIKit
import Alamofire

class FavoritesViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = FavoritesViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoritedGames()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        title = "Favorites"
        collectionViewConfigure()
    }
    
    func getFavoritedGames() {
        self.viewModel.getFavoritedGames()
        
        self.viewModel.updateUI = {
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

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewModel.getItemsCount() == 0 {
            self.collectionView.setEmptyMessage("Henüz favorilere oyun eklemediniz!")
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
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
}
