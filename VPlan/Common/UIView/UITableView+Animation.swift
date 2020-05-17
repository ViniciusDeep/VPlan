//
//  UITableView+Animation.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import UIKit

extension UITableViewCell {

    func animationToRight() {
        self.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, 250, 0, 0)
        self.layer.transform = transform
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
}
