//
//  RegisterContentView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import SnapKit

class RegisterContentView: UIView, ConfigurableView {
   
    let bannerImage = UIImageView().then {
          $0.image = #imageLiteral(resourceName: "signIn")
          $0.contentMode = .scaleAspectFit
    }
    
    let nameField = InteractionTextField(title: "Seu nome:", placeHolder: "Ex: Moreira")
    let emailField = InteractionTextField(title: "Seu e-mail:", placeHolder: "Ex: moreira@gmail.com").then {
        $0.textField.keyboardType = .emailAddress
    }
    let passwordField = InteractionTextField(title: "Seu senha:", placeHolder: "").then {
        $0.textField.isSecureTextEntry = true
    }
    let registerButton = InteractionButton(backgroundColor: #colorLiteral(red: 0.03137254902, green: 0.3411764706, blue: 0.6705882353, alpha: 1), title: "Registrar", titleColor: .white)
    
    
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
        addSubview(nameField)
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(registerButton)
    }
       
    func setupConstraints() {
        bannerImage.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(100)
            make.height.equalTo(150)
            make.centerX.equalTo(snp.centerX)
        }
        
        nameField.snp.makeConstraints { (make) in
            make.top.equalTo(bannerImage.snp.bottom).offset(12)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
        
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(nameField.snp.bottom).offset(12)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.top.equalTo(emailField.snp.bottom).offset(12)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordField.snp.bottom).offset(12)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
    }
}
