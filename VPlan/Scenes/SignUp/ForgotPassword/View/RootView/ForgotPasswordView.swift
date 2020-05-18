//
//  ForgotPasswordView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//
import RxCocoa
import RxSwift
import FirebaseAuth

class ForgotPasswordView: UIViewController {
    
    let contentView = ForgotPasswordContentView()
    let disposeBag = DisposeBag()
    var viewModel: ForgotPasswordViewModel?
    
    convenience init(viewModel: ForgotPasswordViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    func setupView() {
        view = contentView
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveKeyboard)))
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else {return}
        contentView.emailField.textField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        contentView.forgotPasswordButton.rx.tap.bind(to: rx.resetPassword).disposed(by: disposeBag)
        viewModel.resetPasswordErrorSubject.bind(to: rx.showMessageError).disposed(by: disposeBag)
        viewModel.resetPasswordSucessedPublishSubject.bind(to: rx.showMessageSuccess).disposed(by: disposeBag)
    }
}

extension Reactive where Base: ForgotPasswordView {
  var resetPassword: Binder<()> {
       return Binder(base) { (view, _) in
           let alert = UIAlertController(title: "Tudo certo!", message: "Verifique seu e-mail para resetar a sua senha.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
               alert.dismiss(animated: true, completion: nil)
           }))
           view.present(alert, animated: true)
       }
   }
    
   var showMessageSuccess: Binder<()> {
       return Binder(base) { (view, _) in
           view.viewModel?.didResetPassword()
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
