//
//  ProductDetailSpec.swift
//  wishlistTests
//
//  Created by Jerilyn Gonçalves on 03/09/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
@testable import wishlist

class ProductDetailSpec: QuickSpec {
    
    // MARK: - Attributes
    
    var presenter: ProductDetailPresenter!
    var viewMock: ProductDetailViewMock!
    var wireframeMock: ProductsWireframeMock!
    var product: Product!
    
    // MARK: - Tests
    
    override func spec() {
        
        super.spec()
        
        beforeEach {
            self.product = StubModel.product
            self.viewMock = ProductDetailViewMock()
            self.wireframeMock = ProductsWireframeMock()
            self.presenter = StubBuilder.productDetailPresenter(
                view: self.viewMock,
                wireframe: self.wireframeMock,
                product: self.product
            )
        }
        
        afterEach {
            self.product = nil
            self.viewMock = nil
            self.wireframeMock = nil
            self.presenter = nil
        }
        
        describe("test product detail section") {
            
            describe("when product detail section is loaeded") {
                
                beforeEach {
                    self.presenter.onViewDidLoad()
                }
                
                it("view should indicate that it's loading") {
                    expect(self.viewMock.spyShowLoadingCalled).toEventually(beTrue())
                }
            }
        }
        
        describe("when product detail request is completed") {
            
            context("successfully") {
                beforeEach {
                    let path = URL(string: Config.host + Endpoints.Products.product + self.product.id)!.path
                    StubResponse.mockSuccessResponse(for: path, with: "product_success.json")
                    self.presenter.onViewDidLoad()
                }
                it("should dismiss loading indicator and show product") {
                    expect(self.viewMock.spyDismissLoadingCalled).toEventually(beTrue(), timeout: 10)
                    expect(self.viewMock.spyLoadProduct.called).toEventually(beTrue(), timeout: 10)
                }
            }
        }
        
        describe("when user selects update product") {
            beforeEach {
                self.presenter.userSelectedUpdateProduct()
            }
            it("should navigate to update product view") {
                expect(self.wireframeMock.spyShowUpdateProductCalled).toEventually(beTrue())
            }
        }
        
        describe("when user selects remove product") {
            beforeEach {
                self.presenter.userSelectedRemoveProduct()
            }
            it("should show alert with confirmation message") {
                expect(self.viewMock.spyShowAlert.called).toEventually(beTrue())
            }
        }
        
        // TODO: Add tests for product removal after user's confirmation
    }
}
