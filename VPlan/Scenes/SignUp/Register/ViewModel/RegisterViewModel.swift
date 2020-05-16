//
//  RegisterViewModel.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseAuth

enum FieldType {
    case password
    case email
    case name
    case none
}

struct RegisterViewModel {
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let name = BehaviorRelay<String>(value: "")
    let firebaseService: CreatableFirebaseService
    
    let userCreatedPublishSubject = PublishSubject<AuthDataResult>()
    let userCreatedError = PublishSubject<Error>()
      
    var isValid: Observable<Bool>
      
    func isChecked(name: Observable<String>, email: Observable<String>, password: Observable<String>) -> Observable<FieldType> {
        return Observable.combineLatest(self.name.asObservable(), self.email.asObservable(), self.password.asObservable()) { (name, email, password) in
            if !email.fieldIsValid(typeField: .email) {return .email}
            
            if !password.fieldIsValid(typeField: .password) {return .password}
            
            if name.count <= 3 {return .name}

            return .none
         }
      }
    
    init(firebaseService: CreatableFirebaseService) {
        self.firebaseService = firebaseService
        isValid = Observable.combineLatest(self.email.asObservable(), self.password.asObservable(), self.name.asObservable()) { (email, password, name) in
            return email == ""
            && password == "" && name == ""
        }
     }
    
    func registerUser() {
        firebaseService.didRegisterUser(name: name.value, email: email.value, password: password.value) { (result) in
            switch result {
            case .success(let result):
                self.userCreatedPublishSubject.onNext(result)
            case .failure(let error):
                self.userCreatedError.onNext(error)
            }
        }
    }
}
