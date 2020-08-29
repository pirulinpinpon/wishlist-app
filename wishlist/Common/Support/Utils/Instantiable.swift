//
//  Instantiable.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit

enum InstantiateError: Error {
    case initialError
    case identifierError
}

protocol Instantiable {
    static var storyboard: String {get}
    static var bundle: Bundle {get}
    static var identifier: String {get}
}

extension Instantiable where Self: UIViewController {
    static var identifier: String { get{ return "" } }
    static var bundle: Bundle { get{ return Bundle(for: Self.self) } }
}

extension Instantiable {
    
    static func instantiateFromStoryboard() throws -> Self {
        let bundle = Self.bundle
        let storyboard = UIStoryboard(name: Self.storyboard, bundle: bundle)
        var viewController: UIViewController?
        
        if Self.identifier.count > 0 {
            viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        } else {
            guard let vc = storyboard.instantiateInitialViewController() else {
                print("Could not instantiate initial view controller from storyboard: \(Self.storyboard)")
                throw InstantiateError.initialError
            }
            viewController = vc
        }
        
        guard let downcastedVC = viewController as? Self else {
            print("Could not instantiate view controller from storyboard: \(Self.storyboard), identifier: \(String(describing: identifier))")
            throw InstantiateError.identifierError
        }
        return downcastedVC
    }
}

