//
//  FeedPlanView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxCocoa
import RxSwift

class FeedPlanView: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let contentView = FeedPlanContentView()
    
    var viewModel: FeedPlanViewModel?
    
    convenience init(viewModel: FeedPlanViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
         setupView()
         bindUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.fetchPlans()
    }
    
    func setupView() {
        view = contentView
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setupDefaultNavigationBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didOpenCreatePlanView))
        title = "Suas Pautas"
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveKeyboard)))
    }
    
    @objc func didOpenCreatePlanView() {
        let feedPlanView = UINavigationController(rootViewController: CreatePlanView(viewModel: CreatePlanViewModel(firebaseFireStoreService: FirebaseFireStoreService())))
        feedPlanView.modalPresentationStyle = .fullScreen
        self.present(feedPlanView, animated: true, completion: nil)
    }
    
    func bindUI() {
        guard let viewModel = self.viewModel else {return}
        contentView.menuView.actionMenuSubject.bind(to: rx.fetchPlan).disposed(by: disposeBag)
        
        viewModel.plansSubject.bind(to: contentView.tableView.rx.items(cellIdentifier: "cellId", cellType: FeedPlanTableViewCell.self)) { (_, plan, cell) in
            cell.animationToRight()
            cell.feedCellContentView.setup(withPlan: plan)
        }.disposed(by: disposeBag)
    }
}

extension Reactive where Base: FeedPlanView {
    var fetchPlan: Binder<(Bool)> {
        return Binder(base) { (view, isOpen) in
            view.viewModel?.isOpen = isOpen
            view.viewModel?.fetchPlans()
        }
    }
}
