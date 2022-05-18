//
//  MainViewController.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import UIKit
protocol MainViewProtocol: NSObjectProtocol {
    func reloadTableView()
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
        presenter.configure(cell: cell, for: indexPath.row)
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.size.height / 4) - 40
    }
}

extension MainViewController: MainViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}

