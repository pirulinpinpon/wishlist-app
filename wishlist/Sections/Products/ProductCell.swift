//
//  ProductCell.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit
import Nuke

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    func bind(_ product: Product) {
        guard let image = product.images.first, let imageURL = URL(string: image) else { return }
        let request = ImageRequest(url: imageURL)
        Nuke.loadImage(with: request, into: self.imageView)
    }
}
