//
//  CreatePlanView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxCocoa
import RxSwift

class CreatePlanView: UIViewController {
    
    let createPlanContentView = CreatePlanContentView()
    
    let disposeBag = DisposeBag()
    
    var viewModel: CreatePlanViewModel?
       
    convenience init(viewModel: CreatePlanViewModel) {
           self.init()
           self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    func setupView() {
        navigationController?.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.03137254902, green: 0.3411764706, blue: 0.6705882353, alpha: 1), #colorLiteral(red: 0.03137254902, green: 0.3411764706, blue: 0.6705882353, alpha: 1)], startPoint: .topLeft, endPoint: .bottomRight)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        title = "Criar Pauta"
        view = createPlanContentView
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveKeyboard)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.dismissView))
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else {return}
        
        createPlanContentView.titleField.textField.rx.text.orEmpty.bind(to: viewModel.title).disposed(by: disposeBag)
        createPlanContentView.descriptionField.textField.rx.text.orEmpty.bind(to: viewModel.description).disposed(by: disposeBag)
        createPlanContentView.detailsField.textField.rx.text.orEmpty.bind(to: viewModel.details).disposed(by: disposeBag)
        
        viewModel.isChecked(title: createPlanContentView.titleField.textField.rx.text.orEmpty.asObservable(),
                            description: createPlanContentView.descriptionField.textField.rx.text.orEmpty.asObservable(),
                            details: createPlanContentView.detailsField.textField.rx.text.orEmpty.asObservable()).bind(to: createPlanContentView.rx.validateField).disposed(by: disposeBag)
        
        createPlanContentView.registerPlanButton.rx.tap.bind(to: rx.createPlan).disposed(by: disposeBag)
        viewModel.successCreatePlanSubject.bind(to: rx.dismiss).disposed(by: disposeBag)
        viewModel.errorCreatePlanSubject.bind(to: rx.showMessageError).disposed(by: disposeBag)
    }
    
    @objc func dismissView() {self.dismiss(animated: true, completion: nil)}
}

extension Reactive where Base: CreatePlanView {
    var createPlan: Binder<()> {
        return Binder(base) { (view, _) in
            view.viewModel?.didCreatePlan()
        }
    }
    
   var dismiss: Binder<()> {
        return Binder(base) { (view, _) in
            view.dismissView()
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
