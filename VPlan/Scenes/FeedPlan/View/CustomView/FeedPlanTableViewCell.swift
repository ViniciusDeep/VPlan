//
//  FeedPlanTableViewCell.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import SnapKit
 
class FeedPlanTableViewCell: UITableViewCell, ConfigurableView {
   
    let feedCellContentView = FeedPlanContentViewCell()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(feedCellContentView)
    }
       
    func setupConstraints() {
        feedCellContentView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(12)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
            make.bottom.equalTo(snp.bottom).offset(-12)
        }
    }
    
    func setup(withPlan plan: Plan) {
        feedCellContentView.titleLabel.text = plan.title
        feedCellContentView.descriptionLabel.text = plan.description
    }
}
