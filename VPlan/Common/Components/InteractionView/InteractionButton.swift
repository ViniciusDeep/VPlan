//
//  InteractionButton.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import UIKit

class InteractionButton: UIButton {
    var title: String?
    var titleColor: UIColor?
    
    convenience init(backgroundColor: UIColor, title: String, titleColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
        self.title = title
        self.titleColor = titleColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.heightAnchor.constraint(equalToConstant: 48).isActive = true
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
}
