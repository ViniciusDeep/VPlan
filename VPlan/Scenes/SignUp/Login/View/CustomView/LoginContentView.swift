//
//  LoginContentView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//
import SnapKit
import RxCocoa
import RxSwift

class LoginContentView: UIView, ConfigurableView {
   
    let bannerImage = UIImageView().then {
          $0.image = #imageLiteral(resourceName: "signIn")
          $0.contentMode = .scaleAspectFit
    }
    
    let emailField = InteractionTextField(title: "Seu e-mail:", placeHolder: "Ex: moreira@gmail.com").then {
        $0.textField.keyboardType = .emailAddress
    }
    let passwordField = InteractionTextField(title: "Sua senha", placeHolder: "No mínimo 8 caracteres").then {
        $0.textField.isSecureTextEntry = true
    }
    let loginButton = InteractionButton(backgroundColor: #colorLiteral(red: 0.03137254902, green: 0.3411764706, blue: 0.6705882353, alpha: 1), title: "Entrar", titleColor: .white)
    
    
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
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(loginButton)
    }
       
    func setupConstraints() {
        bannerImage.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(100)
            make.height.equalTo(150)
            make.centerX.equalTo(snp.centerX)
        }
        
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(bannerImage.snp.bottom).offset(12)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.top.equalTo(emailField.snp.bottom).offset(12)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordField.snp.bottom).offset(12)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
    }
    
    func update(fieldType: FieldType) {
        switch fieldType {
        case .email:
            self.disableButton()
        case .password:
            self.disableButton()
        case .name:
            self.disableButton()
        case .none:
            loginButton.backgroundColor = #colorLiteral(red: 0.03137254902, green: 0.3411764706, blue: 0.6705882353, alpha: 1)
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.isEnabled = true
        }
    }
    
    func disableButton() {
        loginButton.backgroundColor = .lightGray
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.isEnabled = false
    }
    
}

extension Reactive where Base: LoginContentView {
    var validateField: Binder<(FieldType)> {
        return Binder(base) { (view, fieldType) in
            view.update(fieldType: fieldType)
        }
    }
}
