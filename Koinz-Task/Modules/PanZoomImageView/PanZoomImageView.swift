//
//  PanZoomImageView.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import UIKit

class PanZoomImageView: UIScrollView {

    @IBInspectable
    private var imageName: String? {
        didSet {
            guard let imageName = imageName else {
                return
            }
            imageView.image = UIImage(named: imageName)
        }
    }
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    convenience init(named: String) {
        self.init(frame: .zero)
        self.imageName = named
    }
    
    convenience init(image: UIImage) {
        self.init(frame: .zero)
        self.imageView.image = image
    }
    
    convenience init(url: URL) {
        self.init(frame: .zero)
        self.imageView.kf.setImage(with: url)
    }
    
    private func commonInit() {
        // Setup image view
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        // Setup scroll view
        minimumZoomScale = 1
        maximumZoomScale = 3
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delegate = self
    }

}

extension PanZoomImageView: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
