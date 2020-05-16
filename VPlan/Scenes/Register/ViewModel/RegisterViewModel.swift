//
//  RegisterViewModel.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxSwift
import RxCocoa

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
      
      var isValid: Observable<Bool>
      
    func isChecked(name: Observable<String>, email: Observable<String>, password: Observable<String>) -> Observable<FieldType> {
        return Observable.combineLatest(self.name.asObservable(), self.email.asObservable(), self.password.asObservable()) { (name, email, password) in
            if !email.fieldIsValid(typeField: .email) {return .email}
            
            if !password.fieldIsValid(typeField: .password) {return .password}
            
            if name.count <= 3 {return .name}

            return .none
         }
      }
    
     init() {
        isValid = Observable.combineLatest(self.email.asObservable(), self.password.asObservable(), self.name.asObservable()) { (email, password, name) in
            return email == ""
            && password == "" && name == ""
        }
     }
    
}
