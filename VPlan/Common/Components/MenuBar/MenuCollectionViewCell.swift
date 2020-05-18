//
//  MenuCollectionViewCell.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let titleCell: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.03137254902, green: 0.3411764706, blue: 0.6705882353, alpha: 1)
        setupTitleCell()
    }
    
    func setupTitleCell() {
        addSubview(titleCell)
        NSLayoutConstraint.activate([
            titleCell.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleCell.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleText(_ indexPath: Int) {
        if indexPath == 0 {
            titleCell.text = "Abertas"
        } else {
            titleCell.text = "Fechadas"
        }
    }
}
