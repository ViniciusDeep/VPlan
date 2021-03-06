//
//  FeedPlanContentView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import SnapKit

class FeedPlanContentView: UIView, ConfigurableView {
   
    let tableView = UITableView().then {
        $0.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.register(FeedPlanTableViewCell.self, forCellReuseIdentifier: "cellId")
        $0.separatorStyle = .none
    }
    
    let menuView = MenuTabBarView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        buildViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
           addSubview(menuView)
           addSubview(tableView)
    }
       
    func setupConstraints() {
        menuView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(70)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(menuView.snp.bottom).offset(10)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
    }
}
