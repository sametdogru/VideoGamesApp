//
//  GameDetailsViewController.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import UIKit

class GameDetailsViewController: UIViewController {

    let viewModel = GameDetailsViewModel()
    
    var gameId = "12020"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestForGameDetails(gameId)
    }
}

// MARK : - StoryboardInstantiable
extension GameDetailsViewController: StoryboardInstantiable {
    
    static var storyboardName: String { return "GameDetails" }
    static var storyboardIdentifier: String? { return "GameDetailsViewController" }
}
