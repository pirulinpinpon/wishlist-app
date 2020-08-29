//
//  ProductsVC.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 28/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit

class ProductsVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Public properties
    
    var presenter: ProductsPresenterProtocol?

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIView.animate(
            withDuration: 0.8,
            delay: 0.2,
            options: [.curveEaseInOut, .repeat, .autoreverse],
            animations: {
                self.iconImageView.alpha = 0.0
            },
            completion: nil
        )
    }
}

// MARK: - ProductsUI

extension ProductsVC: ProductsUI {
    
}

// MARK: - Instantiable

extension ProductsVC: Instantiable {
    
    static var storyboard = Constants.Storyboards.products
    static var identifier = Constants.Views.products

}
