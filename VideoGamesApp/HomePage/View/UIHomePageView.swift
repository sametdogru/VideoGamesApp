//
//  UIHomePageView.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 10.02.2022.
//

import Foundation
import UIKit
import Kingfisher

@IBDesignable
class UIHomePageView: UIView {
    static let UIHome_Page_View = "UIHomePageView"
    
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    convenience init(img: String?) {
        self.init()
        if let url = URL(string: img ?? ""){
            imgView.kf.setImage(with: url)
        }
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed("UIHomePageView", owner: self, options: nil)
        pageView.frame = bounds
        pageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        if let url = URL(string: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"){
            imgView.kf.setImage(with: url)
        }
        addSubview(pageView)
    }
}

