//
//  FirebaseService.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore

protocol CreatableFirebaseService {
    func didRegisterUser(name: String, email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    
}


struct FirebaseService: CreatableFirebaseService {
    
    let auth = Auth.auth()
    
    let fireStore = Firestore.firestore()
    
    func didRegisterUser(name: String, email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        self.auth.createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                completion(.failure(err))
            }
            
            if let result = result {
                var ref: DocumentReference?
    
                ref = self.fireStore.collection("users").addDocument(data: [
                                          "name": name,
                                          "uuid": "\(result.user.uid)"
                    ]) { err in
                    if let err = err {
                        completion(.failure(err))
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        }
                    }
                    completion(.success(result))
                }
            }
    }
    
}
