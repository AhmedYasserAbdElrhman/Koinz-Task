//
//  NetworkManager.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import Foundation
import Alamofire
class NetworkManager {
    class func search(page: Int) {
        AF.request(NetworkRoute.search(page: page)) .responseString { response in
            switch response.result {
                
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
}
