//
//  ForgotPasswordViewModel.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseAuth

struct ForgotPasswordViewModel {
    let email = BehaviorRelay<String>(value: "")
    let firebaseService: CreatableAuthFirebaseService
    
    let resetPasswordSucessedPublishSubject = PublishSubject<Void>()
    let resetPasswordErrorSubject = PublishSubject<Error>()
      
    init(firebaseService: CreatableAuthFirebaseService) {
        self.firebaseService = firebaseService
    }
    
    func didResetPassword() {
        firebaseService.sendToResetPassword(email: email.value, onSuccess: {
            self.resetPasswordSucessedPublishSubject.onNext(())
        }) { error in
            self.resetPasswordErrorSubject.onNext(error)
        }
    }
}
