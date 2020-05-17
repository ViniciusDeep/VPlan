//
//  CreatePlanContentView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import SnapKit

class CreatePlanContentView: UIView {
    let bannerImage = UIImageView().then {
              $0.image = #imageLiteral(resourceName: "signIn")
              $0.contentMode = .scaleAspectFit
        }
        
        let titleField = InteractionTextField(title: "Título: ", placeHolder: "Ex: Reunião com comercial")
        let descriptionField = InteractionTextField(title: "Descrição: ", placeHolder: "Ex: Marcar uma reuinão com comercial amanhã")
        let detailsField = InteractionTextField(title: "Detalhes: ", placeHolder: "Ex: Pedir aumento na antecipação de recebíveis")
        let registerPlanButton = InteractionButton(backgroundColor: #colorLiteral(red: 0.03137254902, green: 0.3411764706, blue: 0.6705882353, alpha: 1), title: "Registrar pauta", titleColor: .white)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            buildViewHierarchy()
            setupConstraints()
            backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func buildViewHierarchy() {
            addSubview(bannerImage)
            addSubview(titleField)
            addSubview(descriptionField)
            addSubview(detailsField)
            addSubview(registerPlanButton)
        }
           
        func setupConstraints() {
            bannerImage.snp.makeConstraints { (make) in
                make.top.equalTo(snp.top).offset(100)
                make.height.equalTo(150)
                make.centerX.equalTo(snp.centerX)
            }
            
            titleField.snp.makeConstraints { (make) in
                make.top.equalTo(bannerImage.snp.bottom).offset(12)
                make.left.equalTo(snp.left).offset(12)
                make.right.equalTo(snp.right).offset(-12)
            }
            
            descriptionField.snp.makeConstraints { (make) in
                make.top.equalTo(titleField.snp.bottom).offset(12)
                make.left.equalTo(snp.left).offset(12)
                make.right.equalTo(snp.right).offset(-12)
            }
            
            detailsField.snp.makeConstraints { (make) in
                make.top.equalTo(descriptionField.snp.bottom).offset(12)
                make.left.equalTo(snp.left).offset(12)
                make.right.equalTo(snp.right).offset(-12)
            }
            
            registerPlanButton.snp.makeConstraints { (make) in
                make.top.equalTo(detailsField.snp.bottom).offset(12)
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
                registerPlanButton.backgroundColor = #colorLiteral(red: 0.03137254902, green: 0.3411764706, blue: 0.6705882353, alpha: 1)
                registerPlanButton.setTitleColor(.white, for: .normal)
                registerPlanButton.isEnabled = true
            }
        }
        
        func disableButton() {
            registerPlanButton.backgroundColor = .lightGray
            registerPlanButton.setTitleColor(.black, for: .normal)
            registerPlanButton.isEnabled = false
        }
}
