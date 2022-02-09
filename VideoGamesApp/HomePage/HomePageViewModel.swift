//
//  HomePageViewModel.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import Foundation

class HomePageViewModel {
    
    var updateUI : ()->() = {}
    var updateUIWithError : ()->() = {}

    var response : [HomePageResponse] = [] {
        didSet {
            updateUI()
        }
    }
    
    var gameList : [Results] = []{
        didSet {
            updateUI()
        }
    }
    
    func numberOfSection() -> Int { 1 }
    
    func getItemsCount()->Int {

        return gameList.count
    }
    
    func getItemAtIndex(_ index : Int)->Results{
        
        return gameList[index]
        
    }
    
    public func requestForGameList(_page: String) {
        APIManager.shared.requestGameList(sender: self, key: Constants.shared.key, pageNo: _page, selector:  #selector(self.response(data:)))
    }
    
    @objc func response(data: Any?) {
        if let response = data as? HomePageResponse {
            self.gameList = response.results ?? []
        } else {
            self.updateUIWithError()
        }
    }
}
