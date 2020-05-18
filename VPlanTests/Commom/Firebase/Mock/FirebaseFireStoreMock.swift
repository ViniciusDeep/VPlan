//
//  FirebaseFireStoreMock.swift
//  VPlanTests
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import FirebaseAuth
@testable import VPlan

enum FirestoreMockError: Error {
    case createdPlan
    case fetchedPlan
    case updatedPlan
}

class FirebaseFireStoreMockService: CreatableFirebaseFireStoreService {
    
    var plans: [Plan] = []
    
    
    func createPlan(plan: Plan, onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        if plan.description == "" || plan.details == "" || plan.title == "" {
            return onFailure(FirestoreMockError.createdPlan)
        }
        plans.append(plan)
        return onSuccess()
    }
    
    func fetchPlans(completion: @escaping (Result<[Plan], Error>) -> Void) {
        if plans.isEmpty {
            completion(.failure(FirestoreMockError.fetchedPlan))
        }
        
        completion(.success(self.plans))
    }
    
    func updateStatePlan(isOpen: Bool, uuid: String, onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        let plans = self.plans.filter { $0.uuid == uuid }
        
        if let plan = plans.first {
            self.plans.append(plan)
            onSuccess()
        } else {
            onFailure(FirestoreMockError.updatedPlan)
        }
    }
}
