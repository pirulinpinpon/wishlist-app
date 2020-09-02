//
//  UIView.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 02/09/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit

public extension UIView {

    func addSubviewWithAutolayout(_ childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(childView)
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(
            contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                options: .alignmentMask,
                metrics: nil,
                views: ["childView" : childView]
            )
        )
        
        constraints.append(
            contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                options: .alignmentMask,
                metrics: nil,
                views: ["childView" : childView]
            )
        )
        
        self.addConstraints(constraints)
        self.setNeedsUpdateConstraints()
    }
}
