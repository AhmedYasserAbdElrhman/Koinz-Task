//
//  PhotoTableViewCellViewModel.swift
//  Koinz-Task
//
//  Created by Ahmad Yasser on 18/05/2022.
//

import Foundation
struct PhotoTableViewCellViewModel {
    let url: String
    
    init(photo: Photo) {        
        url = "https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
    }
}
