//
//  FeedPlanView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxCocoa

class FeedPlanView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        navigationController?.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.9882352941, green: 0.7137254902, blue: 0.6235294118, alpha: 1), #colorLiteral(red: 1, green: 0.9254901961, blue: 0.8235294118, alpha: 1)], startPoint: .topLeft, endPoint: .bottomRight)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didOpenCreatePlanView))
        title = "Suas Pautas"
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveKeyboard)))
    }
    
    @objc func didOpenCreatePlanView() {
        let feedPlanView = UINavigationController(rootViewController: CreatePlanView(viewModel: CreatePlanViewModel(firebaseFireStoreService: FirebaseFireStoreService())))
        feedPlanView.modalPresentationStyle = .fullScreen
        self.present(feedPlanView, animated: true, completion: nil)}
}
