//
//  BaseCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 10.02.2022.
//

import UIKit
import Kingfisher

class BaseCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var imgGame: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblReleased: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    
    lazy var formatterddMMyyyy:DateFormatter = {
        let fter = DateFormatter()
        fter.locale = Locale(identifier: "tr_TR")
        fter.dateFormat = "dd.MM.yyyy"
        fter.timeZone = TimeZone(identifier: "UTC")
        return fter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(item: Results?) {
        guard let item = item else {
            return
        }

        lblName.text = item.name
        ratingView.type = .floatRatings
        ratingView.rating = item.rating ?? 0
        
        let date = getDate(date: item.released ?? "")
        let dateStr = formatterddMMyyyy.string(from: date ?? Date())
        lblReleased.text = dateStr
        
        if let url = URL(string: item.background_image ?? ""){
            imgGame.kf.setImage(with: url)
        }
    }
    
    func getDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: date) // replace Date String
    }
}
