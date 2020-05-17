//
//  LoginViewModel.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseAuth

struct LoginViewModel {
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let firebaseService: CreatableAuthFirebaseService
    
    let loginSucessedPublishSubject = PublishSubject<AuthDataResult>()
    let loginErrorSubject = PublishSubject<Error>()
      
    var isValid: Observable<Bool>
      
    func isChecked(email: Observable<String>, password: Observable<String>) -> Observable<FieldType> {
        return Observable.combineLatest(self.email.asObservable(), self.password.asObservable()) { (email, password) in
            if !email.fieldIsValid(typeField: .email) {return .email}
            
            if !password.fieldIsValid(typeField: .password) {return .password}
        
            return .none
         }
      }
    
    init(firebaseService: CreatableAuthFirebaseService) {
        self.firebaseService = firebaseService
        isValid = Observable.combineLatest(self.email.asObservable(), self.password.asObservable()) { (email, password) in
            return email == ""
            && password == ""
        }
     }
    
    func didLoginUser() {
        firebaseService.didLogin(email: email.value, password: password.value) { (result) in
             switch result {
             case .success(let result):
                    self.loginSucessedPublishSubject.onNext(result)
             case .failure(let error):
                    self.loginErrorSubject.onNext(error)
            }
        }
    }
}
