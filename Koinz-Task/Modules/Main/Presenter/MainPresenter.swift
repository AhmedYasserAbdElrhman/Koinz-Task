//
//  MainPresenter.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import Foundation
protocol MainPresenterProtocol: PageablePresenter {
    var numberOfItems: Int {get}
    func viewDidLoad()
    func configure(cell: PhotosTableViewCellProtocol, for row: Int)
    func configure(cell: AdBannerTableViewCellProtocol)
    func didSelect(at index: Int)
}

class MainPresenter {
    // MARK: - Variables
    weak var view: MainViewProtocol!
    var manager: NetworkManagerProtocol!
    private var photosResponse: Photos?
    private var isPresenterFetching = false
    init(view: MainViewProtocol, manager: NetworkManagerProtocol) {
        self.view = view
        self.manager = manager
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    var numberOfItems: Int {
        let count = photosResponse?.photo.count ?? 0
        return count + count / 5
    }
    
    func viewDidLoad() {
        getPhotos(page: 1)
    }
    
    func configure(cell: PhotosTableViewCellProtocol, for row: Int) {
        guard let photo = photosResponse?.photo[row] else {return}
        cell.display(photo: .init(photo: photo))
    }
    
    func configure(cell: AdBannerTableViewCellProtocol) {
        cell.displayBanner()
    }
    
    func didSelect(at index: Int) {
        guard let photo = photosResponse?.photo[index] else {return}
        let urlString = PhotoTableViewCellViewModel(photo: photo).url
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return  }
        view.presentImage(with: url)
    }
}

extension MainPresenter {
    
    var currentPage: Int {
        return photosResponse?.page ?? 0
    }
    
    var lastPage: Int {
        return photosResponse?.pages ?? 0
    }
    
    var isFetching: Bool {
        get {
            isPresenterFetching
        }
        set {
            isPresenterFetching = newValue
        }
    }
    
    func paginate() {
        getPhotos(page: currentPage + 1)
    }

}

extension MainPresenter {
    private func getPhotos(page: Int) {
        isPresenterFetching = true
        manager.search(page: page) { [weak self] result in
            guard let self = self else {return}
            self.isPresenterFetching = false
            switch result {
                
            case .success(let model):
                if page == 1 {
                    self.photosResponse = model
                } else {
                    self.photosResponse?.page = model.page
                    self.photosResponse?.pages = model.pages
                    self.photosResponse?.photo.append(contentsOf: model.photo)
                }
                self.view.reloadTableView()
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
