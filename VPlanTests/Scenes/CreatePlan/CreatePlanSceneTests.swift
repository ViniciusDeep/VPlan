//
//  CreatePlanScene.swift
//  VPlanTests
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import XCTest
import RxSwift
@testable import VPlan

class CreatePlanSceneTests: XCTestCase {

    let createPlanView = CreatePlanView(viewModel: CreatePlanViewModel(firebaseFireStoreService: FirebaseFireStoreMockService()))
    
    
    func testHasErrorInCreatePlan() {
        createPlanView.setupView()
        createPlanView.bindViewModel()
        
        _ = createPlanView.viewModel?.isChecked(title: Observable.just(""),
                                                description: Observable.just("Description Stub"),
                                                details: Observable.just("detatils about stub")).subscribe(onNext: { (planField) in
                   XCTAssertEqual(planField, PlanField.title)
               }).disposed(by: DisposeBag())
        
        createPlanView.viewModel?.firebaseFireStoreService.createPlan(plan: Plan(description: "", title: "", isOpen: true, details: "", uuid: ""), onSuccess: {
        }, onFailure: { (error) in
             if let err = error as? FirestoreMockError {
             XCTAssertEqual(FirestoreMockError.createdPlan, err)
            }
        })
    }
    
    func testHasCheckedFields() {
        createPlanView.setupView()
        createPlanView.bindViewModel()
        
        createPlanView.viewModel?.firebaseFireStoreService.createPlan(plan: Plan(description: "Stub", title: "Stub", isOpen: true, details: "Stub, Stub, Stub", uuid: "StubID"), onSuccess: {
        }, onFailure: { (error) in
            XCTAssertNil(error)
        })
        
        createPlanView.viewModel?.didCreatePlan()
        
        createPlanView.viewModel?.successCreatePlanSubject.subscribe(onNext: { (event) in
            XCTAssertNotNil(event)
            }).disposed(by: DisposeBag())
        
        createPlanView.viewModel?.errorCreatePlanSubject.subscribe(onNext: { (error) in
            XCTAssertNotNil(error)
        }).disposed(by: DisposeBag())
        createPlanView.dismissView()
    }
}
