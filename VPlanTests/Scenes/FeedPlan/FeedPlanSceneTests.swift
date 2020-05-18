//
//  FeedPlanSceneTests.swift
//  VPlanTests
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import XCTest
import RxSwift
@testable import VPlan

class FeedPlanSceneTests: XCTestCase {

    let feedPlanView = FeedPlanView(viewModel: FeedPlanViewModel(firebaseFireStoreService: FirebaseFireStoreMockService()))
    
    func testPlanViewSetup() {
        feedPlanView.setupView()
        feedPlanView.bindUI()
        feedPlanView.didOpenLogoutView()
        feedPlanView.didOpenCreatePlanView()
    }
    
    func testFeedPlanViewModel() {
        feedPlanView.viewModel?.firebaseFireStoreService.createPlan(plan: Plan(description: "Stub", title: "Stub", isOpen: true, details: "Stub, Stub, Stub", uuid: "StubID"), onSuccess: {
        }, onFailure: { (error) in
            XCTAssertNil(error)
        })
        
        feedPlanView.viewModel?.fetchPlans()
        
        feedPlanView.viewModel?.plansSubject.subscribe(onNext: { (plans) in
            XCTAssertNotNil(plans)
        }).disposed(by: DisposeBag())
        
        
        feedPlanView.viewModel?.errorPlanSubject.subscribe(onNext: { (error) in
            XCTAssertNotNil(error)
        }).disposed(by: DisposeBag())
        
        
        feedPlanView.viewModel?.updateStatus(status: true, uuid: "StubID")
        
        feedPlanView.viewModel?.firebaseFireStoreService.fetchPlans(completion: { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let plans):
                XCTAssertTrue(plans.last?.isOpen ?? false)
                XCTAssertNotNil(plans)
            }
        })
    }
}
