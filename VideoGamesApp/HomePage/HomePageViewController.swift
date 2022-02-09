//
//  HomePageViewController.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import UIKit
import Alamofire

class HomePageViewController: UIViewController {

    let viewModel = HomePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.requestForGameList(_page: "1")
    }
    
    @IBAction func go(_ sender: Any) {
        let vc = GameDetailsViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
