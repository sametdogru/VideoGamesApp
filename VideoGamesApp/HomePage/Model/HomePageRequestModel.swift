//
//  HomeRequestModel.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import Foundation
import UIKit

class HomePageRequestModel: NetworkRequest<HomePageResponse> {
    override init() {
        super.init()
        endpoint = "/games?key="
        checkInternet = true
    }
}
