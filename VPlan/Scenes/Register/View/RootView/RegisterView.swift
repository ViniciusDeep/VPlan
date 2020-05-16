//
//  Register.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxCocoa
import RxSwift

class RegisterView: UIViewController {
    
    let registerContentView = RegisterContentView()
    
    let disposeBag = DisposeBag()
    
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    fileprivate func setupView() {
        view = registerContentView
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveKeyboard)))
    }
    
    func bindViewModel() {
        registerContentView.nameField.textField.rx.text.orEmpty.bind(to: viewModel.name).disposed(by: disposeBag)
        registerContentView.emailField.textField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        registerContentView.passwordField.textField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        
   
        
        viewModel.isChecked(name: registerContentView.nameField.textField.rx.text.orEmpty.asObservable(),
                            email: registerContentView.emailField.textField.rx.text.orEmpty.asObservable(),
                            password: registerContentView.passwordField.textField.rx.text.orEmpty.asObservable()).bind(to: registerContentView.rx.validateField).disposed(by: disposeBag)
        
    }
    
    @objc fileprivate func moveKeyboard() {view.endEditing(true)}
}
