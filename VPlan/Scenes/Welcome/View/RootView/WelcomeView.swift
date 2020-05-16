//
//  LoginView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import SnapKit

class WelcomeView: UIViewController {
    
    let welcomeContentView = WelcomeContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Bem Vindo"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupContentView()
    }
    
    fileprivate func setupContentView() {
        view = welcomeContentView
    }
}
