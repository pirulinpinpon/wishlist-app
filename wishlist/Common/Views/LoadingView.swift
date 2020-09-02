//
//  LoadingView.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 02/09/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: IBOutlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadView()
    }
    
    // MARK: - Public methods
    
    func show(in containerView: UIView) {
        containerView.addSubviewWithAutolayout(self)
        self.alpha = 0
        self.blurEffectView.effect = nil
        self.isHidden = false
        
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.alpha = 1
                self.blurEffectView.effect = UIBlurEffect(style: .regular)
            },
            completion: { _ in
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
        )
    }
    
    func dismiss() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.2,
            animations: {
                self.alpha = 0
                self.blurEffectView.effect = nil
            },
            completion: { _ in
                self.iconImageView.layer.removeAllAnimations()
                self.isHidden = true
                self.removeFromSuperview()
            }
        )
    }
    
    // MARK: - Private helpers
    
    private func loadView() {
        Bundle.main.loadNibNamed(String(describing: LoadingView.self), owner: self, options: nil)
        self.addSubviewWithAutolayout(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
