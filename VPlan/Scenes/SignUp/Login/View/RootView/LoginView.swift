//
//  LoginView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxCocoa
import RxSwift
import FirebaseAuth

class LoginView: UIViewController {
    
    let contentView = LoginContentView()
    let disposeBag = DisposeBag()
    var viewModel: LoginViewModel?
    
    convenience init(viewModel: LoginViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    fileprivate func setupView() {
        view = contentView
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveKeyboard)))
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else {return}
        
        contentView.emailField.textField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        contentView.passwordField.textField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        
        viewModel.isChecked(email: contentView.emailField.textField.rx.text.orEmpty.asObservable(),
                            password: contentView.passwordField.textField.rx.text.orEmpty.asObservable()).bind(to: contentView.rx.validateField).disposed(by: disposeBag)
        
        viewModel.loginSucessedPublishSubject.bind(to: rx.moveToFeed).disposed(by: disposeBag)
        
        viewModel.loginErrorSubject.bind(to: rx.showMessageError).disposed(by: disposeBag)
        
        contentView.loginButton.rx.tap.bind(to: rx.login).disposed(by: disposeBag)
    }
    
    @objc fileprivate func moveKeyboard() {view.endEditing(true)}
}

extension Reactive where Base: LoginView {
   var login: Binder<()> {
       return Binder(base) { (view, _) in
           view.viewModel?.didLoginUser()
       }
   }
    
   var moveToFeed: Binder<(AuthDataResult)> {
        return Binder(base) { (view, _) in
            view.navigationController?.pushViewController(UIViewController(), animated: true)
        }
    }
        
    var showMessageError: Binder<(Error)> {
            return Binder(base) { (view, error) in
                let alert = UIAlertController(title: "Erro:", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    alert.dismiss(animated: true, completion: nil)
                }))
                view.present(alert, animated: true)
       }
    }
}
