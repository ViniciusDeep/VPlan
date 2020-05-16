//
//  Coordinator.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

struct AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        loadFirstScene()
    }
    
    func loadFirstScene() {
        window.rootViewController = UINavigationController(rootViewController: LoginView())
        window.makeKeyAndVisible()
    }
}
