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
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    // MARK: - Public properties
    
    var presenter: ProductsPresenterProtocol?
    
    // MARK: - Private properties
    
    private let cellSpacing: CGFloat = 2
    private let columns: CGFloat = 3
    private var cellSize: CGFloat = 0
    private lazy var loadingView = LoadingView()

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.Texts.Products.title
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.onViewWillAppear()
    }
    
    // MARK: - Private helpers
    
    private func setupNavigationBar() {
        let addProductButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle"),
            style: .plain,
            target: self,
            action: #selector(didSelectAddProductButton)
        )
        addProductButton.tintColor = Colors.tint
        self.navigationItem.rightBarButtonItem  = addProductButton
    }
    
    // MARK: - IBActions
    
    @IBAction func didSelectAddProductButton() {
        self.presenter?.userSelectedAddProduct()
    }
}

// MARK: - ProductsUI

extension ProductsVC: ProductsUI {
    
    func showLoader() {
        self.loadingView.show(in: self.view)
    }
    
    func dismissLoader() {
        self.loadingView.dismiss()
    }
    
    func showProducts() {
        self.collectionView.reloadData()
    }
    
    func showAlert(title: String, message: String, retryAction: AlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: retryAction.title, style: .default, handler: { _ in
            retryAction.action()
        }))
        alert.view.tintColor = Colors.tint
        self.present(alert, animated: true)
    }
}


// MARK: - UICollectionViewDelegate

extension ProductsVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.userSelectedProduct(at: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource

extension ProductsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.numberOfProducts() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.product, for: indexPath) as? ProductCell, let product = self.presenter?.product(at: indexPath.row) else { return UICollectionViewCell() }
        cell.bind(product)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let emptySpace = layout.sectionInset.left + layout.sectionInset.right + (self.columns * self.cellSpacing - 1)
        self.cellSize = (self.view.frame.size.width - emptySpace) / self.columns
        
        return CGSize(width: self.cellSize, height: self.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellSpacing
    }
}

// MARK: - Instantiable

extension ProductsVC: Instantiable {
    
    static var storyboard = Constants.Storyboards.products
    static var identifier = Constants.Views.products
}
