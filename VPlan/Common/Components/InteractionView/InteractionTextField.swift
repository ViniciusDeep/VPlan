//
//  InteractionTextField.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import SnapKit
import RxCocoa
import RxSwift

class InteractionTextField: UIView, ConfigurableView {
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .lightGray
    }
    
    let textField = UITextField().then {
        $0.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    }
    
    convenience init(title: String, placeHolder: String) {
        self.init()
        self.titleLabel.text = title
        self.textField.placeholder = placeHolder
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textField.delegate = self
        buildViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(textField)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
            make.height.equalTo(48)
        }
    }
}

extension InteractionTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
