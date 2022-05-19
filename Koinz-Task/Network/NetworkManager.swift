//
//  NetworkManager.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import Foundation
import Alamofire
protocol NetworkManagerProtocol {
    func search(page: Int, completion: @escaping (Result<Photos, Error>) -> Void)
}
class NetworkManager {
    var searchCalled = false
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
          let userInfo = ["date": Date()]
          return CachedURLResponse(
            response: response.response,
            data: response.data,
            userInfo: userInfo,
            storagePolicy: .allowed)
        })
        return Session(configuration: configuration, cachedResponseHandler: responseCacher)
    }()
    
}

extension NetworkManager: NetworkManagerProtocol {
    func search(page: Int, completion: @escaping (Result<Photos, Error>) -> Void) {
        sessionManager.request(NetworkRoute.search(page: page)) .responseData { [weak self] response in
            guard let self = self else {return}
            self.searchCalled = true
            switch response.result {
                
            case .success(let value):
                do {
                    let model = try JSONDecoder().decode(PhotosSearchModel.self, from: value)
                    completion(.success(model.photos))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
                print(error)
            }
        }
    }
}
