//
//  FavoritesViewModel.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 10.02.2022.
//

import Foundation

class FavoritesViewModel {
    
    var updateUI : ()->() = {}
    var updateUIWithError : (_ error : String)->() = { error in}
    
    var favoritedGames : [Results] = []{
        didSet {
            updateUI()
        }
    }
    
    func numberOfSection() -> Int { 1 }
    
    func getItemsCount()->Int {

        return favoritedGames.count
    }
    
    func getItemAtIndex(_ index : Int)->Results{
        
        return favoritedGames[index]
    }
    
    func getFavoritedGames() {
        if let data = UserDefaults.standard.data(forKey: "favorited") {
            do {
                let decoder = JSONDecoder()
                let favoritedData = try decoder.decode([Results].self, from: data)
                self.favoritedGames = favoritedData
            } catch {
                updateUIWithError("Bir hata oluştu.")
            }
        }
    }
}
