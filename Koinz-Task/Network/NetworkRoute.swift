//
//  NetworkRoute.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import Foundation
import Alamofire
enum NetworkRoute: URLRequestConvertible {
    
    case search(page: Int)
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .search(let page):
            let params = SearchQueryParams(page: page)
            return params.getBody()
        }
    }
    
    var path: String {
        return "services/rest"
    }
    
    
    
}
