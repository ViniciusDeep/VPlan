//
//  RegisterSceneTests.swift
//  VPlanTests
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import XCTest
import RxSwift
@testable import VPlan

class RegisterSceneTests: XCTestCase {

    let registerView = RegisterView(viewModel: RegisterViewModel(firebaseService: FirebaseAuthMockService()))

    func testFirebaseServiceAtViewModel() {
        registerView.bindViewModel()
        registerView.viewModel?.firebaseService.didLogin(email: "Email invalid", password: "Invalid", completion: { (result) in
            switch result {
            case .failure(let error):
                if let err = error as? MockError {
                    XCTAssertEqual(MockError.invalidField, err)
                }
            case .success(let success):
                XCTAssertNil(success)
            }
        })
        
        _ = registerView.viewModel?.isChecked(name: Observable.just("stub"), email: Observable.just("stub@gmail.com"), password: Observable.just("Password10"))
    
        registerView.viewModel?.registerUser()
        
        registerView.viewModel?.firebaseService.didRegisterUser(name: "Stub", email: "Stub", password: "Stub", completion: { (result) in
            switch result {
            case .failure(let error):
                if let err = error as? MockError {
                    XCTAssertEqual(MockError.invalidField, err)
                }
            case .success(let success):
                XCTAssertNil(success)
            }
        })
        
        
        registerView.viewModel?.firebaseService.didRegisterUser(name: "StubName", email: "stub@gmail.com", password: "StubBru10", completion: { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let success):
                XCTAssertNotNil(success)
            }
        })
        
        registerView.viewModel?.userCreatedPublishSubject.subscribe(onNext: { (event) in
            XCTAssertNotNil(event)
        }).disposed(by: DisposeBag())
        
        
        registerView.viewModel?.userCreatedError.subscribe(onNext: { (error) in
            XCTAssertNotNil(error)
        }).disposed(by: DisposeBag())
    }
}
