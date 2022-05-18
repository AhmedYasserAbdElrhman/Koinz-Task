//
//  MainPresenter.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import Foundation
protocol MainPresenterProtocol {
    func viewDidLoad()
}

class MainPresenter {
    weak var view: MainViewProtocol!
    var manager: NetworkManagerProtocol!
    init(view: MainViewProtocol, manager: NetworkManagerProtocol) {
        self.view = view
        self.manager = manager
    }
}

extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
        getPhotos(page: 1)
    }
}


extension MainPresenter {
    private func getPhotos(page: Int) {
        manager.search(page: page) {
            
        }
    }
}
