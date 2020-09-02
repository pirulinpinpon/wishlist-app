//
//  UpdateProductVC.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit

class UpdateProductVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productTitleLabel: UILabel! {
        didSet {
            productTitleLabel.text = "Your product name"
        }
    }
    @IBOutlet weak var productTextField: UITextField! {
        didSet {
            productTextField.placeholder = "Add a name for your product"
            productTextField.returnKeyType = .next
            productTextField.delegate = self
        }
    }
    @IBOutlet weak var imageURLLabel: UILabel! {
        didSet {
            imageURLLabel.text = "Link to product image"
        }
    }
    @IBOutlet weak var imageURLTextField: UITextField! {
        didSet {
            imageURLTextField.placeholder = "Add a link to your product's image"
            imageURLTextField.returnKeyType = .next
            imageURLTextField.delegate = self
        }
    }
    @IBOutlet weak var merchantNameTitleLabel: UILabel! {
        didSet {
            merchantNameTitleLabel.text = "Product sold by"
        }
    }
    @IBOutlet weak var merchantNameTextField: UITextField! {
        didSet {
            merchantNameTextField.placeholder = "Add the of your product's merchant"
            merchantNameTextField.returnKeyType = .next
            merchantNameTextField.delegate = self
        }
    }
    @IBOutlet weak var merchantURLTitleLabel: UILabel! {
        didSet {
            merchantURLTitleLabel.text = "Link to product store"
        }
    }
    @IBOutlet weak var merchantURLTextField: UITextField! {
        didSet {
            merchantURLTextField.placeholder = "Add a link to the product"
            merchantURLTextField.returnKeyType = .done
            merchantURLTextField.delegate = self
        }
    }
    @IBOutlet weak var updateButton: UIButton! {
        didSet {
            updateButton.contentHorizontalAlignment = .left
            updateButton.semanticContentAttribute = .forceRightToLeft
            updateButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 0)
            updateButton.setImage(UIImage(systemName: "chevron.left.circle"), for: .normal)
            updateButton.isEnabled = false
        }
    }
    
    // MARK: - Private properties

    private lazy var loadingView = LoadingView()
    
    // MARK: - Public properties
    
    var presenter: UpdateProductPresenterProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.onViewDidLoad()
        self.registerForNotifications()
    }
    
    // MARK: - IBAction
    
    @IBAction func didTapOnUpdateButton(_ sender: Any) {
        self.presenter?.userSelectedUpdateButton()
    }
    
    // MARK: - Private helpers

    private func registerForNotifications() {
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard self.scrollView.contentOffset.y < 42 else { return }
        self.scrollView.contentOffset = CGPoint(x: 0, y: self.scrollView.contentOffset.y + 42)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.scrollView.contentOffset = .zero
    }
}

// MARK: - UpdateProductUI

extension UpdateProductVC: UpdateProductUI {
    
    func loadProduct(_ product: Product?) {
        self.updateButton.setTitle(product != nil ? "update product" : "add product", for: .normal)
        guard let product = product else { return}
        self.productTextField.text = product.title
        self.imageURLTextField.text = product.images.first
        self.merchantNameTextField.text = product.merchant
        self.merchantURLTextField.text = product.url
    }

    func showLoading() {
        self.loadingView.show(in: self.view)
    }
    
    func dismissLoading() {
        self.loadingView.dismiss()
    }
}

// MARK: - UITextFieldDelegate

extension UpdateProductVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.productTextField:
            self.imageURLTextField.becomeFirstResponder()
        case self.imageURLTextField:
            self.merchantNameTextField.becomeFirstResponder()
        case self.merchantNameTextField:
            self.merchantURLTextField.becomeFirstResponder()
        case self.merchantURLTextField:
            self.view.endEditing(true)
        default:
            break
        }
        return true
    }
}

// MARK: - Instantiable

extension UpdateProductVC: Instantiable {
    
    static var storyboard = Constants.Storyboards.products
    static var identifier = Constants.Views.updateProduct
}
