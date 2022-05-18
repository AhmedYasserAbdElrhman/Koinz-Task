//
//  PageablePresenter.swift
//  
//
//  Created by Ahmed Yasser on 31/08/2021.
//

import Foundation

protocol PageablePresenter {
    var currentPage: Int {get}
    var lastPage: Int {get}
    var isFetching: Bool { get set}
    func paginate()

}
