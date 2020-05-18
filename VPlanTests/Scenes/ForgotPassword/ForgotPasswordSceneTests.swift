//
//  ForgotPasswordSceneTests.swift
//  VPlanTests
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import XCTest
import RxSwift
@testable import VPlan

class ForgotPasswordSceneTests: XCTestCase {

    let forgotPasswordView = ForgotPasswordView(viewModel: ForgotPasswordViewModel(firebaseService: FirebaseAuthMockService()))

    func load() {
        forgotPasswordView.viewDidLoad()
        forgotPasswordView.bindViewModel()
        forgotPasswordView.setupView()
    }
    
    func testProfileViewModel() {
        self.load()
        
        forgotPasswordView.viewModel?.didResetPassword()
        
        forgotPasswordView.viewModel?.resetPasswordErrorSubject.subscribe(onNext: { (error) in
            XCTAssertNotNil(error)
        }).disposed(by: DisposeBag())
        
        forgotPasswordView.viewModel?.resetPasswordSucessedPublishSubject.subscribe(onNext: { (event) in
                   XCTAssertNotNil(event)
        }).disposed(by: DisposeBag())
    }
}
