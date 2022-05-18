//
//  SearchQueryParams.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import Foundation

struct SearchQueryParams {
    typealias Keys = FlickrAPIKeys
    typealias Values = FlickrAPIValues
    var page = 1
    var text = "Color"
    func getBody() -> [String: Any] {
        return [ Keys.Page: page,
                 Keys.Method: Values.SearchMethod,
                 Keys.ResponseFormat: Values.ResponseFormat,
                 Keys.Text: text,
                 Keys.PerPage: Values.PerPage,
                 Keys.noJsonCallback: Values.noJsonCallback,
                 Keys.APIKey: Values.APIKey,
        ]
    }
}
