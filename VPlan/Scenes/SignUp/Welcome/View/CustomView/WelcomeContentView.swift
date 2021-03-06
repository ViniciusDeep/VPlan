//
//  LoginContentView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import SnapKit
import RxSwift

class WelcomeContentView: UIView, ConfigurableView {
    
    let forgotPassowrdLabelSubject = PublishSubject<Void>()
    
    let bannerImage = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "welcome")
        $0.contentMode = .scaleAspectFit
    }
    
    let loginButton = InteractionButton(backgroundColor: #colorLiteral(red: 0.03137254902, green: 0.3411764706, blue: 0.6705882353, alpha: 1), title: "Entrar", titleColor: .white)
    
    let registerButton = InteractionButton(backgroundColor: #colorLiteral(red: 0.9333333333, green: 0.9450980392, blue: 0.9568627451, alpha: 1), title: "Cadastrar", titleColor: .black)
    
    lazy var forgotPassowrdLabel = UILabel().then {
        $0.text = "Esqueci minha senha"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 16)
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forgotPasswordHasTapped)))
        $0.isUserInteractionEnabled = true
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
           addSubview(loginButton)
           addSubview(registerButton)
           addSubview(forgotPassowrdLabel)
    }
       
    func setupConstraints() {
        bannerImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(loginButton.snp.top).offset(-10)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(forgotPassowrdLabel.snp.top).offset(-15)
            make.left.equalTo(snp.left).offset(12)
            make.right.equalTo(snp.right).offset(-12)
        }
        
        forgotPassowrdLabel.snp.makeConstraints { (make) in
                   make.bottom.equalTo(snp.bottomMargin).offset(-15)
                   make.centerX.equalTo(snp.centerX)
        }
    }
    
    @objc func forgotPasswordHasTapped() {
        forgotPassowrdLabelSubject.onNext(())
    }
}
