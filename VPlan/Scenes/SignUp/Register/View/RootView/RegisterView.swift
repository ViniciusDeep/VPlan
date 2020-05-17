//
//  Register.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxCocoa
import RxSwift
import FirebaseAuth

class RegisterView: UIViewController {
    
    let registerContentView = RegisterContentView()
    
    let disposeBag = DisposeBag()
    
    var viewModel: RegisterViewModel?
    
    convenience init(viewModel: RegisterViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
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
        guard let viewModel = viewModel else {return}
        
        registerContentView.nameField.textField.rx.text.orEmpty.bind(to: viewModel.name).disposed(by: disposeBag)
        registerContentView.emailField.textField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        registerContentView.passwordField.textField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        
        viewModel.isChecked(name: registerContentView.nameField.textField.rx.text.orEmpty.asObservable(),
                            email: registerContentView.emailField.textField.rx.text.orEmpty.asObservable(),
                            password: registerContentView.passwordField.textField.rx.text.orEmpty.asObservable()).bind(to: registerContentView.rx.validateField).disposed(by: disposeBag)
        
        viewModel.userCreatedPublishSubject.bind(to: rx.moveToFeed).disposed(by: disposeBag)
        
        viewModel.userCreatedError.bind(to: rx.showMessageError).disposed(by: disposeBag)
        
        registerContentView.registerButton.rx.tap.bind(to: rx.createUser).disposed(by: disposeBag)
    }
}

extension Reactive where Base: RegisterView {
    var createUser: Binder<()> {
        return Binder(base) { (view, _) in
            view.viewModel?.registerUser()
        }
    }
    
   var moveToFeed: Binder<(AuthDataResult)> {
        return Binder(base) { (view, _) in
            let feedPlanView = UINavigationController(rootViewController: FeedPlanView(viewModel: FeedPlanViewModel(firebaseFireStoreService: FirebaseFireStoreService())))
            feedPlanView.modalPresentationStyle = .fullScreen
            view.present(feedPlanView, animated: true, completion: nil)
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
