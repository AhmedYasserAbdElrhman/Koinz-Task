//
//  MainViewController.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import UIKit
protocol MainViewProtocol: NSObjectProtocol {
    func reloadTableView()
    func presentImage(with url: URL)
    func presentBanner()
}
class MainViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    
    // MARK: - Variables
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupTableView()
    }
    
    
    // MARK: - Functions
    private func setupTableView() {
        let nib = UINib(nibName: "PhotoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PhotoTableViewCell")
    }

}


extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as? PhotoTableViewCell else {return UITableViewCell()}
        if indexPath.row % 6 == 5 {
            presenter.configure(cell: cell)
        } else {
            let index = indexPath.row - (indexPath.row / 6)
            presenter.configure(cell: cell, for: index)
        }
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.size.height / 4) - 40
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row % 6 == 5 {
            presentBanner()
        } else {
            let index = indexPath.row - (indexPath.row / 6)
            presenter.didSelect(at: index)
        }
    }
}

extension MainViewController: MainViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    
    func presentImage(with url: URL) {
        let imageView = PanZoomImageView(url: url)
        let vc =  ShowPhotoViewController(imageView: imageView)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: true)

    }
    
    
    func presentBanner() {
        let imageView = PanZoomImageView(image: .init())
        let vc =  ShowPhotoViewController(imageView: imageView)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: true)
    }
}

extension MainViewController: PageableView {
    var scroll: UIScrollView {
        return tableView
    }
    
    var pageablePresenter: PageablePresenter {
        return presenter
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        didEndScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        didEndScrolling()
    }

    
}
