//
//  ProdEnv.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import Foundation
import UIKit

class ProdEnv: NSObject {
    static let shared = ProdEnv()
    
    var baseUrl = "https://api.rawg.io/api"
}
