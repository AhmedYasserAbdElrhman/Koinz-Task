//
//  URLRequestConvertibleEx.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import Foundation
import Alamofire

protocol URLRequestConvertible: Alamofire.URLRequestConvertible {
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
}

extension URLRequestConvertible {
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
        let stringURL = (FlickrURL.APIURL + path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlRequest = URLRequest(url: URL(string: stringURL)!)
        
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}
