//
//  ConfigurableView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import UIKit

protocol ConfigurableView: UIView {
    func setupView()
    func buildViewHierarchy()
    func setupConstraints()
}

extension ConfigurableView {
    func setupView() {
        func buildViewHierarchy() {}
        func setupConstraints() {}
    }
}
