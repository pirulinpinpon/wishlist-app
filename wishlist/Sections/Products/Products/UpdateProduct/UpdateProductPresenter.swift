//
//  UpdateProductPresenter.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

protocol UpdateProductUI: class {
    func loadForUpdate(_ product: Product)
    func loadForAdd()
    func showLoading()
    func dismissLoading()
    func enableUpdateButton()
    func disableUpdateButton()
}

protocol UpdateProductPresenterProtocol {
    func onViewDidLoad()
    func userEnteredTitle(_ title: String?)
    func userEnteredImageURL(_ imageURL: String?)
    func userEnteredMerchantURL(_ merchantURL: String?)
    func userEnteredMerchant(_ merchant: String?)
    func userSelectedUpdateButton()
}

class UpdateProductPresenter {
    
    // MARK: - Public properties
    
    weak var view: UpdateProductUI?
    let wireframe: ProductsWireframeProtocol?
    let interactor: ProductInteractorProtocol?
    
    // MARK: - Private properties
    
    private var product: Product?
    private var title: String?
    private var imageURL: String?
    private var merchantURL: String?
    private var merchant: String?

    // MARK: - Initializers

    init(view: UpdateProductUI, wireframe: ProductsWireframeProtocol, interactor: ProductInteractorProtocol, product: Product?) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
        self.product = product
    }
    
    // MARK: - Private methods
    
    private func shouldEnableCreate() -> Bool {
        guard let title = self.title, !title.isEmpty, let imageURL = self.imageURL, !imageURL.isEmpty, let merchantURL = self.merchantURL, !merchantURL.isEmpty, let merchant = self.merchant, !merchant.isEmpty else { return false }
        return true
    }
    
    private func createProduct() {
        guard self.shouldEnableCreate(), let title = self.title, let imageURL = self.imageURL, let merchantURL = self.merchantURL, let merchant = self.merchant else { return }
        self.view?.showLoading()
        self.interactor?.addProduct(title: title, imageURL: imageURL, merchant: merchant, merchantURL: merchantURL) { result in
            self.view?.dismissLoading()
            switch result {
            case .success:
                self.wireframe?.dismissAddProduct()
            case .failure:
                // TODO: Handle error and show alert to user
                break
            }
        }
    }
    
    private func updateProduct(_ product: Product) {
        self.view?.showLoading()
        self.interactor?.updateProduct(product) { result in
            self.view?.dismissLoading()
            switch result {
            case .success:
                self.wireframe?.dismissUpdateProduct()
            case .failure:
                // TODO: Handle error and show alert to user
                break
            }
        }
    }
}

// MARK: - UpdateProductPresenterProtocol

extension UpdateProductPresenter: UpdateProductPresenterProtocol {

    func onViewDidLoad() {
        if let product = self.product {
            self.view?.loadForUpdate(product)
        } else {
            self.view?.loadForAdd()
        }
    }

    func userSelectedUpdateButton() {
        if let product = self.product {
            self.updateProduct(product)
        } else {
            self.createProduct()
        }
    }
    
    func userEnteredTitle(_ title: String?) {
        guard let title = title else {
            self.view?.disableUpdateButton()
            return
        }
        if self.product != nil {
            self.product?.title = title
            self.view?.enableUpdateButton()
        } else {
            self.title = title
            self.shouldEnableCreate() ? self.view?.enableUpdateButton() : self.view?.disableUpdateButton()
        }
    }
    
    func userEnteredImageURL(_ imageURL: String?) {
        guard let imageURL = imageURL else {
            self.view?.disableUpdateButton()
            return
        }
        if self.product != nil {
            self.product?.images = [imageURL]
            self.view?.enableUpdateButton()
        } else {
            self.imageURL = imageURL
            self.shouldEnableCreate() ? self.view?.enableUpdateButton() : self.view?.disableUpdateButton()
        }
    }
    
    func userEnteredMerchantURL(_ merchantURL: String?) {
        guard let merchantURL = merchantURL else {
            self.view?.disableUpdateButton()
            return
        }
        if self.product != nil {
            self.product?.url = merchantURL
            self.view?.enableUpdateButton()
        } else {
            self.merchantURL = merchantURL
            self.shouldEnableCreate() ? self.view?.enableUpdateButton() : self.view?.disableUpdateButton()
        }
    }
    
    func userEnteredMerchant(_ merchant: String?) {
        guard let merchant = merchant else {
            self.view?.disableUpdateButton()
            return
        }
        if self.product != nil {
            self.product?.merchant = merchant
            self.view?.enableUpdateButton()
        } else {
            self.merchant = merchant
            self.shouldEnableCreate() ? self.view?.enableUpdateButton() : self.view?.disableUpdateButton()
        }
    }
}
