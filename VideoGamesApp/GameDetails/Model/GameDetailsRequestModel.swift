//
//  GameDetailsRequestModel.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import Foundation
import UIKit

class GameDetailsRequestModel: NetworkRequest<Results> {
    override init() {
        super.init()
        endpoint = "/games/"
        checkInternet = true
    }
}
