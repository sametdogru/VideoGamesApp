//
//  BaseViewController.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 10.02.2022.
//

import UIKit

class BaseViewController: UIViewController {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    func gameListModelLoaded(){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.backButtonTitle = ""
        overrideUserInterfaceStyle = .light
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    public func showAlert(_ message: String){
        let alert = UIAlertController(title: "Uyarı!", message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Tamm", style: .default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    public func goToGameDetails(id: String?) {
        let vc = GameDetailsViewController.instantiate()
        guard let id = id else { return }
        vc.gameId = id
        self.present(vc, animated: true, completion: nil)
    }
}

extension BaseViewController {
    
    func showHUD( _ userInteractionEnable:Bool = false) {
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .gray)
        }
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = userInteractionEnable
    }
    
    func hideHUD() {
        self.activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
}
