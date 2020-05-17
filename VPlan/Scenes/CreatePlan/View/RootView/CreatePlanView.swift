//
//  CreatePlanView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxCocoa

class CreatePlanView: UIViewController {
    
    let createPlanContentView = CreatePlanContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        navigationController?.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.9882352941, green: 0.7137254902, blue: 0.6235294118, alpha: 1), #colorLiteral(red: 1, green: 0.9254901961, blue: 0.8235294118, alpha: 1)], startPoint: .topLeft, endPoint: .bottomRight)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        title = "Criar Pauta"
        view = createPlanContentView
    }
}
