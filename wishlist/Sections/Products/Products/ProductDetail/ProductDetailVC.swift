//
//  ProductDetailVC.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit
import Nuke

class ProductDetailVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var merchantWebsiteButton: UIButton! {
        didSet {
            merchantWebsiteButton.contentHorizontalAlignment = .left
            merchantWebsiteButton.semanticContentAttribute = .forceRightToLeft
            merchantWebsiteButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 0)
            merchantWebsiteButton.setImage(UIImage(systemName: "globe"), for: .normal)
        }
    }
    @IBOutlet weak var createdDateLabel: UILabel!
        
    // MARK: - Public properties
    
    var presenter: ProductDetailPresenterProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.presenter?.onViewDidLoad()
    }
    
    // MARK: - Private helpers
    
    private func setupNavigationBar() {
        let addProductButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.slash"),
            style: .plain,
            target: self,
            action: #selector(didSelectRemoveProductButton)
        )
        addProductButton.tintColor = Colors.tint
        self.navigationItem.rightBarButtonItem  = addProductButton
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapOnMerchantWebsiteButton(_ sender: Any) {
        self.presenter?.userSelectedMerchantWebsite()
    }
    
    @IBAction func didSelectRemoveProductButton() {
        self.presenter?.userSelectedRemoveProduct()
    }
}

// MARK: - ProductDetailUI

extension ProductDetailVC: ProductDetailUI {
    
    func loadProduct(_ product: Product) {
        self.titleLabel.text = product.title.lowercased()
        self.merchantWebsiteButton.setTitle(Constants.Texts.ProductDetail.merchantTitle.replacingOccurrences(of: "%s", with: product.merchant.lowercased()), for: .normal)
        self.createdDateLabel.text = product.createdAt.timeIntervalSinceNow.friendlyString
        guard let image = product.images.first, let imageURL = URL(string: image) else { return }
        let request = ImageRequest(url: imageURL)
        Nuke.loadImage(with: request, into: self.imageView)
    }
}

// MARK: - Instantiable

extension ProductDetailVC: Instantiable {
    
    static var storyboard = Constants.Storyboards.products
    static var identifier = Constants.Views.productDetail
}
