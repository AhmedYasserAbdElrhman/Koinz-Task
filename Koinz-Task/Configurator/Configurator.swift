//
//  Configurator.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import Foundation
import UIKit

struct Configurator {
    
    static func mainView() -> UIViewController {
        let vc = MainViewController()
        let network = NetworkManager()
        let presenter = MainPresenter(view: vc, manager: network)
        vc.presenter = presenter
        return vc
    }
}
