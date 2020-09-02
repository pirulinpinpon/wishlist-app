//
//  ProductsSpec.swift
//  wishlistTests
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
@testable import wishlist

class ProductsSpec: QuickSpec {
    
    // MARK: - Attributes
    
    var presenter: ProductsPresenter!
    var viewMock: ProductsViewMock!
    var wireframeMock: ProductsWireframeMock!
    
    // MARK: - Tests
    
    override func spec() {
        
        super.spec()
        
        beforeEach {
            self.viewMock = ProductsViewMock()
            self.wireframeMock = ProductsWireframeMock()
            self.presenter = StubBuilder.productsPresenter(
                view: self.viewMock,
                wireframe: self.wireframeMock
            )
        }
        
        afterEach {
            self.viewMock = nil
            self.wireframeMock = nil
            self.presenter = nil
        }
        
        describe("test products section") {
            
            describe("when products section appears") {
                
                beforeEach {
                    self.presenter.onViewWillAppear()
                }
                
                it("view should indicate that it's loading") {
                    expect(self.viewMock.spyShowLoaderCalled).toEventually(beTrue())
                }
            }
        }
        
        describe("when products request is completed") {
            
            context("successfully") {
                beforeEach {
                    let path = URL(string: Config.host + Endpoints.Products.products)!.path
                    StubResponse.mockSuccessResponse(for: path, with: "products_success.json")
                    self.presenter.onViewWillAppear()
                }
                it("should dismiss loading indicator and show products") {
                    expect(self.viewMock.spyDismissLoaderCalled).toEventually(beTrue(), timeout: 10)
                    expect(self.viewMock.spyShowProductsCalled).toEventually(beTrue(), timeout: 10)
                }
            }
            
            context("with error") {
                beforeEach {
                    let path = URL(string: Config.host + Endpoints.Products.products)!.path
                    StubResponse.mockFailureResponse(for: path, with: "products_failure.json")
                    self.presenter.onViewWillAppear()
                }
                it("should show alert with error message") {
                    expect(self.viewMock.spyDismissLoaderCalled).toEventually(beTrue())
                    expect(self.viewMock.spyShowAlert.called).toEventually(beTrue())
                }
            }
        }
        
        describe("when user selects a product") {
            beforeEach {
                self.presenter.products = [StubModel.product]
                self.presenter.userSelectedProduct(at: 0)
            }
            it("should navigate to product detail view") {
                expect(self.wireframeMock.spyShowProductDetail.called).toEventually(beTrue())
                expect(self.wireframeMock.spyShowProductDetail.product?.id).toEventually(equal(StubModel.product.id))
            }
        }

    }
}
