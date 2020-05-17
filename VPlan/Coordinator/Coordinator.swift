//
//  Coordinator.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        if Auth.auth().currentUser == nil {
            window.rootViewController = UINavigationController(rootViewController: WelcomeView())
        } else {
            window.rootViewController = UINavigationController(rootViewController: FeedPlanView())
        }
        window.makeKeyAndVisible()
    }
}
