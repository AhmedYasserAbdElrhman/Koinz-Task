//
//  NetworkManager.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import Foundation
import Alamofire
protocol NetworkManagerProtocol {
    func search(page: Int, completion: @escaping () -> Void)
}
class NetworkManager {
    var searchCalled = false
}

extension NetworkManager: NetworkManagerProtocol {
    func search(page: Int, completion: @escaping () -> Void) {
        AF.request(NetworkRoute.search(page: page)) .responseString { [weak self] response in
            guard let self = self else {return}
            self.searchCalled = true
            completion()
            switch response.result {
                
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
}
