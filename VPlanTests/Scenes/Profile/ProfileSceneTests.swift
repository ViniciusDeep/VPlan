//
//  ProfileSceneTests.swift
//  VPlanTests
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import XCTest
import RxSwift
@testable import VPlan

class ProfileSceneTests: XCTestCase {

    let profileView = ProfileView(viewModel: ProfileViewModel(firebaseAuthService: FirebaseAuthMockService()))

    func loadProfileView() {
        profileView.viewDidLoad()
        profileView.bindViewModel()
        profileView.dismissView()
        profileView.setupView()
    }
    
    func testProfileViewModel() {
        self.loadProfileView()
        
        profileView.viewModel?.name = "Stub"
        profileView.viewModel?.email = "stub@gmail.com"
        
        profileView.viewModel?.didReceiveInfonrmationFromUser(completion: { (userInfo) in
            XCTAssertEqual(FirebaseAuthMockService.emailSut, userInfo.email)
            XCTAssertEqual(FirebaseAuthMockService.nameSut, userInfo.name)
        })
        
        profileView.viewModel?.didLogout()
        
        
        profileView.viewModel?.logoutPassthroughSubject.subscribe(onNext: { (event) in
            XCTAssertNotNil(event)
        }).disposed(by: DisposeBag())
        
        profileView.viewModel?.logoutErrorSubject.subscribe(onNext: { (error) in
            XCTAssertNotNil(error)
        }).disposed(by: DisposeBag())
        
    }
}
