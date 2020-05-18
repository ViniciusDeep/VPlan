//
//  ProfileContentView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//
import SnapKit
import RxCocoa
import RxSwift

class ProfileContentView: UIView, ConfigurableView {
   
    let bannerImage = UIImageView().then {
          $0.image = #imageLiteral(resourceName: "signIn")
          $0.contentMode = .scaleAspectFit
    }
    
    let logoutButton = InteractionButton(backgroundColor: #colorLiteral(red: 0.03137254902, green: 0.3411764706, blue: 0.6705882353, alpha: 1), title: "Sair", titleColor: .white)
    
    let nameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .lightGray
    }
    
    let emailLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .lightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(bannerImage)
        addSubview(nameLabel)
        addSubview(emailLabel)
        addSubview(logoutButton)
    }
       
    func setupConstraints() {
        bannerImage.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(100)
            make.height.equalTo(150)
            make.centerX.equalTo(snp.centerX)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bannerImage.snp.bottom).offset(12)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
        
        logoutButton.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom).offset(12)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
    }
    
    func setup(userInfo: (email: String, name: String)) {
        self.emailLabel.text = userInfo.email
        self.nameLabel.text = userInfo.name
    }
}
