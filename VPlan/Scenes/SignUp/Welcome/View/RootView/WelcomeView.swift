//
//  LoginView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseAuth

class WelcomeView: UIViewController {
    
    let welcomeContentView = WelcomeContentView()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContentView()
        bindUI()
    }
    
    func setupView() {
        view.backgroundColor = .white
        title = "Bem Vindo ao VPlan"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupContentView() {
        view = welcomeContentView
    }
    
    func bindUI() {
        welcomeContentView.registerButton.rx.tap.bind(to: rx.moveToRegister).disposed(by: disposeBag)
        welcomeContentView.loginButton.rx.tap.bind(to: rx.moveToSignIn).disposed(by: disposeBag)
        welcomeContentView.forgotPassowrdLabelSubject.bind(to: rx.moveToResetPassword).disposed(by: disposeBag)
    }
}

extension Reactive where Base: WelcomeView {
    var moveToRegister: Binder<()> {
        return Binder(base) { (view, _) in
            view.navigationController?.pushViewController(RegisterView(viewModel: RegisterViewModel(firebaseService: FirebaseAuthService())), animated: true)
        }
    }
    
    var moveToSignIn: Binder<()> {
        return Binder(base) { (view, _) in
            view.navigationController?.pushViewController(LoginView(viewModel: LoginViewModel(firebaseService: FirebaseAuthService())), animated: true)
        }
    }
    
    var moveToResetPassword: Binder<()> {
        return Binder(base) { (view, _) in
            view.navigationController?.pushViewController(ForgotPasswordView(viewModel: ForgotPasswordViewModel(firebaseService: FirebaseAuthService())), animated: true)
        }
    }
}
