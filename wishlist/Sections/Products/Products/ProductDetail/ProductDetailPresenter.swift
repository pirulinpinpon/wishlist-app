//
//  ProductDetailPresenter.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

protocol ProductDetailUI: class {
    typealias AlertAction = (title: String, action: () -> Void)
    func loadProduct(_ product: Product)
    func showAlert(title: String, message: String, continueAction: AlertAction, cancelAction: AlertAction)
    func showLoading()
    func dismissLoading()
}

protocol ProductDetailPresenterProtocol {
    func onViewDidLoad()
    func userSelectedRemoveProduct()
    func userSelectedUpdateProduct()
    func userSelectedMerchantWebsite()
}

class ProductDetailPresenter {
    
    // MARK: - Public properties
    
    weak var view: ProductDetailUI?
    let wireframe: ProductsWireframeProtocol?
    let interactor: ProductInteractorProtocol?
    
    // MARK: - Private properties
    
    private var product: Product?
    
    // MARK: - Initializers
    
    init(view: ProductDetailUI, wireframe: ProductsWireframeProtocol, interactor: ProductInteractorProtocol, product: Product) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
        self.product = product
    }
    
    // MARK: - Private methods
    
    private func loadProduct(_ product: Product) {
        self.view?.showLoading()
        self.interactor?.product(id: product.id) { result in
            self.view?.dismissLoading()
            switch result {
            case .success:
                self.view?.loadProduct(product)
            case .failure:
                // TODO: Handle error and show alert to user
                break
            }
        }
    }
    
    private func removeProduct(_ product: Product) {
        self.view?.showLoading()
        self.interactor?.removeProduct(product) { result in
            self.view?.dismissLoading()
            switch result {
            case .success:
                self.wireframe?.dismissProductDetail()
            case .failure:
                // TODO: Handle error and show alert to user
                break
            }
        }
    }
}

// MARK: - ProductDetailPresenterProtocol

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    func onViewDidLoad() {
        guard let product = self.product else { return }
        self.loadProduct(product)
    }
    
    func userSelectedMerchantWebsite() {
        guard let merchantWebsite = self.product?.url, let merchantWebsiteURL = URL(string: merchantWebsite) else { return }
        self.wireframe?.openURL(merchantWebsiteURL)
    }
    
    func userSelectedUpdateProduct() {
        guard let product = self.product else { return }
        self.wireframe?.showUpdateProduct(product)
    }
    
    func userSelectedRemoveProduct() {
        guard let product = self.product else { return }
        self.view?.showAlert(
            title: Constants.Texts.ProductDetail.alertTitle,
            message: Constants.Texts.ProductDetail.alertMessage.replacingOccurrences(of: "%s", with: product.title),
            continueAction: (title: Constants.Texts.ProductDetail.continueActionTitle, action: {
                self.removeProduct(product)
            }),
            cancelAction: (title: Constants.Texts.ProductDetail.cancelActionTitle, action: {})
        )
    }
}
