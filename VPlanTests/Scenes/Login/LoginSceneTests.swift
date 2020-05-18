//
//  LoginSceneTests.swift
//  VPlanTests
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import XCTest
import RxSwift
@testable import VPlan

class LoginSceneTests: XCTestCase {

    let loginView = LoginView(viewModel: LoginViewModel(firebaseService: FirebaseAuthMockService()))

    func testFirebaseServiceAtViewModel() {
        loginView.bindViewModel()
        loginView.viewModel?.firebaseService.didLogin(email: "Email invalid", password: "Invalid", completion: { (result) in
            switch result {
            case .failure(let error):
                if let err = error as? MockError {
                    XCTAssertEqual(MockError.invalidField, err)
                }
            case .success(let success):
                XCTAssertNil(success)
            }
        })
        
        
        loginView.viewModel?.firebaseService.didLogin(email: "email@gmai.com", password: "Invalid10", completion: { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let success):
                XCTAssertNotNil(success)
            }
        })
        
        _ = loginView.viewModel?.isChecked(email: Observable.just("stub@gmail.com"), password: Observable.just("StubPassword1")).subscribe(onNext: { (fieldType) in
            XCTAssertNotNil(fieldType)
            }).disposed(by: DisposeBag())
        
        _ = loginView.viewModel?.isChecked(email: Observable.just("stub@gmail.com"), password: Observable.just("password")).subscribe(onNext: { (fieldType) in
        XCTAssertNotNil(fieldType)
        }).disposed(by: DisposeBag())
        
        _ = loginView.viewModel?.isChecked(email: Observable.just("stu"), password: Observable.just("Password1")).subscribe(onNext: { (fieldType) in
        XCTAssertNotNil(fieldType)
        }).disposed(by: DisposeBag())
        
        loginView.viewModel?.loginErrorSubject.subscribe(onNext: { (error) in
            XCTAssertNotNil(error)
        }).disposed(by: DisposeBag())
        
        
        loginView.viewModel?.loginSucessedPublishSubject.subscribe(onNext: { (event) in
            XCTAssertNotNil(event)
        }).disposed(by: DisposeBag())
        
        
        loginView.viewModel?.didLoginUser()
    }
}
