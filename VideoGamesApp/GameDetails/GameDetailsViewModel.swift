//
//  GameDetailsViewModel.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import Foundation

class GameDetailsViewModel {
    
    var updateUI : ()->() = {}
    var updateUIWithError : ()->() = {}

    var gameDetails: GameDetailsResponse? {
        didSet {
            updateUI()
        }
    }
    
    public func requestForGameDetails(_ id: String) {
        APIManager.shared.requestGameDetails(sender: self, key: Constants.shared.key, id: id, selector: #selector(self.response(data:)))
    }
    
    @objc func response(data: Any?) {
        if let response = data as? GameDetailsResponse {
            self.gameDetails = response
        } else {
            self.updateUIWithError()
        }
    }
}
