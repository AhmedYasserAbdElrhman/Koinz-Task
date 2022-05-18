//
//  PhotoTableViewCell.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import UIKit
import Kingfisher
protocol PhotosTableViewCellProtocol {
    func display(photo: PhotoTableViewCellViewModel)
}

class PhotoTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension PhotoTableViewCell: PhotosTableViewCellProtocol {
    func display(photo: PhotoTableViewCellViewModel) {
        guard let url = URL(string: photo.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {return}
        self.photoImageView.kf.setImage(with: url)
    }
}
