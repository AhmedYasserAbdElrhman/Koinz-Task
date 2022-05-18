//
//  MainPresenter.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import Foundation
protocol MainPresenterProtocol {
    var numberOfItems: Int {get}
    func viewDidLoad()
    func configure(cell: PhotosTableViewCellProtocol, for row: Int)
}

class MainPresenter {
    // MARK: - Variables
    weak var view: MainViewProtocol!
    var manager: NetworkManagerProtocol!
    private var photosResponse: Photos?
    init(view: MainViewProtocol, manager: NetworkManagerProtocol) {
        self.view = view
        self.manager = manager
    }
}

extension MainPresenter: MainPresenterProtocol {
    var numberOfItems: Int {
        return photosResponse?.photo.count ?? 0
    }
    
    func viewDidLoad() {
        getPhotos(page: 1)
    }
    
    func configure(cell: PhotosTableViewCellProtocol, for row: Int) {
        guard let photo = photosResponse?.photo[row] else {return}
        cell.display(photo: .init(photo: photo))
    }
}


extension MainPresenter {
    private func getPhotos(page: Int) {
        manager.search(page: page) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
                
            case .success(let model):
                self.photosResponse = model
                self.view.reloadTableView()
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
