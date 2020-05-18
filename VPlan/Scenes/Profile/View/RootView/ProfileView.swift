//
//  ProfileView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//
import RxCocoa
import RxSwift
import FirebaseAuth

class ProfileView: UIViewController {
    
    let contentView = ProfileContentView()
    let disposeBag = DisposeBag()
    var viewModel: ProfileViewModel?
    
    convenience init(viewModel: ProfileViewModel) {
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
        navigationController?.navigationBar.setupDefaultNavigationBar()
        title = "Perfil"
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveKeyboard)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.dismissView))
    }
    
    @objc func dismissView() {self.dismiss(animated: true, completion: nil)}
    
    func bindViewModel() {
        guard let viewModel = viewModel else {return}
        viewModel.logoutPassthroughSubject.bind(to: rx.logout).disposed(by: disposeBag)
        viewModel.logoutErrorSubject.bind(to: rx.showMessageError).disposed(by: disposeBag)
        contentView.logoutButton.rx.tap.bind(to: rx.didLogout).disposed(by: disposeBag)
        viewModel.didReceiveInfonrmationFromUser {self.contentView.setup(userInfo: $0)}
    }
}

extension Reactive where Base: ProfileView {
    var didLogout: Binder<()> {
        return Binder(base) { (view, _) in
            view.viewModel?.didLogout()
        }
    }
    
    var logout: Binder<()> {
        return Binder(base) { (view, _) in
            let welcomeView = UINavigationController(rootViewController: WelcomeView())
            welcomeView.modalPresentationStyle = .fullScreen
            view.present(welcomeView, animated: true, completion: nil)
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
