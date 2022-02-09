//
//  Network.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import Foundation
import Alamofire
import UIKit

class NetworkRequest<RM: Codable>: Request {
    
    var endpoint: String = ""
    var path: String = ""
    var checkInternet = false
    
    func send(httpMethod: String, completion: @escaping (RM?, (Error?, String?)?, ResponseEmpty?) -> Void) {
        
        if checkInternet {
            guard hasInternet() else {
                  //AppUtils.shared.showAlertWithTitle(title: "7/24", message: "İnternet bağlantınızı kontrol ediniz.")
                return
            }
        }
                
        createURLString()

        let safeURL = path.addingPercentEncoding(withAllowedCharacters: (NSCharacterSet.urlQueryAllowed))
        var urlRequest = URLRequest(url: URL(string: safeURL!)!)
        urlRequest.httpMethod = httpMethod

        let contentType = "application/json"
        urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        print(urlRequest)
        
        Alamofire.request(urlRequest).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).responseJSON { (response) in
            switch response.result {
            case.success(let data):
                do {
                    let theJSONData = try JSONSerialization.data(withJSONObject: data as Any, options: [])
                    let response = try JSONDecoder().decode(RM.self, from: theJSONData)
                    print(response)
                    completion(response, nil, nil)
                }
                catch {
                    print(error)
                    do {
                        let theJSONData = try JSONSerialization.data(withJSONObject: data as Any, options: [])
                        let empty = try JSONDecoder().decode(ResponseEmpty.self, from: theJSONData)
                        completion(nil, nil, empty)
                    }
                    catch {
                        print(error)
                        completion(nil, nil, nil)
                    }
                }
            case .failure(let error):
                print(error)
                
                if let data = response.data {
                    let errResponse = String(data: data, encoding: .utf8)
                    completion(nil, (error, errResponse), nil)
                }
            }
        }
    }
    
    func hasInternet() -> Bool {
        if !(NetworkReachabilityManager()?.networkReachabilityStatus != .notReachable && NetworkReachabilityManager()?.networkReachabilityStatus != .unknown) {
            return false
        }
        return true
    }

    func createURLString() {
        path = ProdEnv.shared.baseUrl + endpoint
    }
}

protocol Request: AnyObject {
    var endpoint: String { get }
    var checkInternet: Bool { get }
}


