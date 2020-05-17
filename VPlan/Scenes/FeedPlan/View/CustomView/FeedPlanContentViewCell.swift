//
//  FeedPlanContentViewCell.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import SnapKit

class FeedPlanContentViewCell: UIView, ConfigurableView {
    
    let trackLayerView = TrackLayerView(trackColor: CGColor.random())
    
    let titleLabel = UILabel().then {
            $0.text = "Personal"
            $0.font = .systemFont(ofSize: 18)
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "Apenas uma breve descrição sobre a vida."
        $0.font = .systemFont(ofSize: 14)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
        setupShadow()
    }
    
    fileprivate func setupShadow() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func buildViewHierarchy() {
       addSubview(trackLayerView)
       addSubview(titleLabel)
       addSubview(descriptionLabel)
    }
       
    func setupConstraints() {
        trackLayerView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(32)
            make.left.equalTo(snp.left).offset(32)
            make.bottom.equalTo(snp.bottom)
            make.width.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(8)
            make.left.equalTo(trackLayerView.snp.right).offset(18)
            make.right.equalTo(snp.right).offset(-8)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(trackLayerView.snp.right).offset(18)
            make.right.equalTo(snp.right).offset(-8)
            make.bottom.equalTo(snp.bottom).offset(-12)
        }
    }
}
