//
//  FirebaseFirestoreService.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore

protocol CreatableFirebaseFireStoreService {
    func createPlan(plan: Plan, onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void)
    func fetchPlans(completion: @escaping (Result<[Plan], Error>) -> Void)
}

struct FirebaseFireStoreService: CreatableFirebaseFireStoreService {
    
    private let fireStore = Firestore.firestore()
    
    func createPlan(plan: Plan, onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        fireStore.collection("users").document(FirebaseAuthService().getCurrentUserUID()).collection("plans")
            .addDocument(data: [
            "title": plan.title,
            "description": plan.description,
            "details": plan.details,
            "isOpen": plan.isOpen
        ]) { error in
            if let err = error {
                onFailure(err)
                } else {
                    onSuccess()
            }
        }
    }
    
    func fetchPlans(completion: @escaping (Result<[Plan], Error>) -> Void) {
        fireStore.collection("users")
            .document(FirebaseAuthService()
                .getCurrentUserUID()).collection("plans").getDocuments { (snapshot, error) in
                    if let error = error {
                        completion(.failure(error))
                    }
                    
                    if let snapshot = snapshot {
                        let plans = snapshot.documents.map { (document) -> Plan in
                            let data = document.data()
                            return Plan(description: data["description"] as? String ?? "",
                                        title: data["title"] as? String ?? "",
                                        isOpen: data["isOpen"] as? Bool ?? false,
                                        details: data["details"] as? String ?? "")
                        }
                        
                        completion(.success(plans))
                }
        }
    }
    
    func updatePlan() {
        
    }
}

struct Plan: Decodable {
    let description: String
    let title: String
    let isOpen: Bool
    let details: String
}
