//
//  GameDetailsViewController.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import UIKit

class GameDetailsViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var imgGame: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblMetaCriticRate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    let viewModel = GameDetailsViewModel()
    var favoritedGames = [Results]()
    var gameId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameDetailsRequest()
    }
    
    func gameDetailsRequest() {
        showHUD()
        self.viewModel.requestForGameDetails(gameId)
        
        self.viewModel.updateUI = {
            self.hideHUD()
            let model = self.viewModel.gameDetails
            self.lblName.text = model?.name
            self.lblReleaseDate.text = model?.released
            self.lblMetaCriticRate.text = String(describing: model?.metacritic ?? 0)
            self.lblDescription.text = model?.description?.html2String
            self.btnLike.setImage(UIImage(named: "favorite"), for: .normal)
            self.btnLike.isHidden = false
            self.closeBtn.isHidden = false
            self.checkButton()

            if let url = URL(string: model?.background_image ?? ""){
                self.imgGame.kf.setImage(with: url)
            }
        }
        
        self.viewModel.updateUIWithError = { error in
            self.hideHUD()
            self.showAlert(error)
        }
    }
    
    func checkButton() {
        guard let favoritedGames = self.viewModel.gameDetails else { return }
        if let data = UserDefaults.standard.data(forKey: "favorited") {
            do {
                let decoder = JSONDecoder()
                let favoritedData = try decoder.decode([Results].self, from: data)
                
                if favoritedData.contains(where: {$0.id == favoritedGames.id}) {
                    btnLike.setImage(UIImage(named: "selectedFavorite"), for: .normal)
                } else {
                    btnLike.setImage(UIImage(named: "favorite"), for: .normal)
                }
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
    
    func checkFavoriteGame() {
        guard let favoritedGames = self.viewModel.gameDetails else { return }
        var data = getData()

        if btnLike.currentImage == UIImage(named: "selectedFavorite") {
            if data.contains(where: {$0.id == favoritedGames.id}) {
                data.removeAll(where: {$0.id == favoritedGames.id})
                setData(data: data)
                btnLike.setImage(UIImage(named: "favorite"), for: .normal)
            } else {
                data.append(favoritedGames)
                setData(data: data)
                btnLike.setImage(UIImage(named: "selectedFavorite"), for: .normal)
            }
        } else {
            data.append(favoritedGames)
            setData(data: data)
            btnLike.setImage(UIImage(named: "selectedFavorite"), for: .normal)
        }
    }
    
    @IBAction func clickedLike(_ sender: UIButton) {
        checkFavoriteGame()
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK : - StoryboardInstantiable
extension GameDetailsViewController: StoryboardInstantiable {
    
    static var storyboardName: String { return "GameDetails" }
    static var storyboardIdentifier: String? { return "GameDetailsViewController" }
}

extension GameDetailsViewController {
    
    // Cache
    func getData()-> [Results] {
        var favoritedDatam = [Results]()
        if let data = UserDefaults.standard.data(forKey: "favorited") {
            do {
                let decoder = JSONDecoder()
                let favoritedData = try decoder.decode([Results].self, from: data)
                favoritedDatam = favoritedData
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return favoritedDatam
    }
    
    func setData(data: [Results]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(data)
            UserDefaults.standard.set(data, forKey: "favorited")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
}
