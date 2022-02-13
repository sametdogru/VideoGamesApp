//
//  HomePageViewModel.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import Foundation

class HomePageViewModel {
    
    var getMoreGame: Bool = false
    var updateUI : ()->() = {}
    var updateUIWithError : (_ error : String)->() = { error in}
    var isSearched = false
    
    var gameList : [Results] = []{
        didSet {
            getMoreGame = true
            updateUI()
        }
    }
    
    var filteredGameList = [Results]()
    
    func numberOfSection() -> Int { 1 }
    
    func getItemsCount()->Int {
        if isSearched {
            return gameList.count
        }
        return gameList.count - 3
    }
    
    func getItemAtIndex(_ index : Int)->Results{
        if isSearched {
            return gameList[index]
        }
        return gameList[index + 3]
    }
    
    func getItem()-> [Results] {
        return gameList
    }
    
    public func requestForGameList(page: Bool? = false) {
        
        APIManager.shared.requestGameList(sender: self, key: Constants.shared.key, page: page ?? false, selector:  #selector(self.response(data:)))
    }
    
    @objc func response(data: Any?) {
        
        if let response = data as? HomePageResponse {
            if self.gameList.count > 0 {
                self.gameList.append(contentsOf: response.results ?? [])
            } else {
                self.gameList = response.results ?? []
            }
            UserDefaults.standard.set(response.next, forKey: "LZY")
        } else {
            self.updateUIWithError("Bir sorun oluştu.")
        }
    }
}
