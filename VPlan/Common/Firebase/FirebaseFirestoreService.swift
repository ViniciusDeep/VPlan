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
}
