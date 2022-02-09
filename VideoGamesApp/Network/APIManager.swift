//
//  APIManager.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import Foundation

class APIManager: NSObject {
    
    static let shared = APIManager()
    
    func requestGameList(sender: AnyObject?, key: String, pageNo: String, selector: Selector?) {

        let req = HomePageRequestModel()
        if !key.isEmpty {
            req.endpoint = req.endpoint + key + "&\(pageNo)"
        }
        
        print("path : \(req.endpoint)")
        
        req.send(httpMethod: Constants().HttpMethod_GET) { (model, errorTuple, empty) in

            do {
                if let response = model {
                    _ = sender?.perform(selector, with: response)
                    return
                }
                else if errorTuple != nil {
                    let error = errorTuple?.0
                    
                    guard error == nil else {
                        let errResponse = errorTuple?.1
                        if let data = errResponse?.data(using: String.Encoding.utf8) {
                            let errorResult = try JSONDecoder().decode(HomePageResponse.self, from: data)
                                print(errorResult)
                        }
                        return
                    }
                }
            }
            catch {
                print("Error occured")
            }
        }
    }
    
    func requestGameDetails(sender: AnyObject?, key: String, id: String,selector: Selector?) {

        let req = GameDetailsRequestModel()
        if !key.isEmpty {
            req.endpoint = req.endpoint + id + "?key=\(key)"
        }

        req.send(httpMethod: Constants().HttpMethod_GET) { (model, errorTuple, empty) in

            do {
                if let response = model {
                    _ = sender?.perform(selector, with: response)
                    return
                }
                else if errorTuple != nil {
                    let error = errorTuple?.0
                    
                    guard error == nil else {
                        let errResponse = errorTuple?.1
                        if let data = errResponse?.data(using: String.Encoding.utf8) {
                            let errorResult = try JSONDecoder().decode(GameDetailsResponse.self, from: data)
                                print(errorResult)
                        }
                        return
                    }
                }
            }
            catch {
                print("Error occured")
            }
        }
    }
}
