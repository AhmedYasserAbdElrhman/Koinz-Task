//
//  ShowPhotoViewController.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import UIKit

class ShowPhotoViewController: UIViewController {

    let panZoomImageView: PanZoomImageView
    
    
    init(imageView: PanZoomImageView) {
        self.panZoomImageView = imageView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBlurView()
        layoutImage()
        setupLeftButton(tint: .black)
    }
    
    
    
    // MARK: - Functions
    private func addBlurView() {
        let effect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: effect)
        view.addSubview(blurView)
        let constriants = [
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
        view.addConstraints(constriants)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.layoutIfNeeded()
    }
    
    private func layoutImage() {
        view.addSubview(self.panZoomImageView)
        let constriants = [
            panZoomImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            panZoomImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            panZoomImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            panZoomImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)]
        view.addConstraints(constriants)
        self.panZoomImageView.translatesAutoresizingMaskIntoConstraints = false
        view.layoutIfNeeded()
    }
    
    private func setupLeftButton(tint: UIColor) {
        let button = UIButton()
        button.tintColor = tint
        button.setImage(#imageLiteral(resourceName: "close.png"), for: .normal)
        button.addTarget(self, action: #selector(btnDismissTaped(_:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }

    // MARK:- IBActions
    
    @IBAction func btnDismissTaped(_ sender: UIButton) {
        dismiss(animated: true)
    }


}
