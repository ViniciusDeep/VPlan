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
    func createPlan(title: String, description: String, details: String, onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void)
    func fetchPlans(completion: @escaping (Result<[Plan], Error>) -> Void)
}

struct FirebaseFireStoreService: CreatableFirebaseFireStoreService {
    
    private let fireStore = Firestore.firestore()
    
    func createPlan(title: String, description: String, details: String, onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        fireStore.collection("users").document(FirebaseAuthService().getCurrentUserUID()).collection("plans")
            .addDocument(data: [
            "title": title,
            "description": description,
            "details": details,
            "isOpen": true
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
}

struct Plan: Decodable {
    let description: String
    let title: String
    let isOpen: Bool
    let details: String
}
