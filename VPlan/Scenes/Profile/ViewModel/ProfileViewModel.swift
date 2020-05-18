//
//  ProfileViewModel.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxSwift
import FirebaseAuth

struct ProfileViewModel {
    
    var name: String = ""
    
    var email: String = ""
    
    let firebaseAuthService: CreatableAuthFirebaseService
    
    let logoutPassthroughSubject = PublishSubject<()>()
    let logoutErrorSubject = PublishSubject<Error>()
    
    init(firebaseAuthService: CreatableAuthFirebaseService) {
        self.firebaseAuthService = firebaseAuthService
    }
    
    func didReceiveInfonrmationFromUser(completion: @escaping ((email: String, name: String)) -> Void) {
        firebaseAuthService.getUserInfo { (result) in
            switch result {
            case .failure(let error):
                self.logoutErrorSubject.onNext(error)
            case .success(let userInfo):
                completion(userInfo)
            }
        }
    }
    
    func didLogout() {
        firebaseAuthService.didLogoutUser { (error) in
            if let error = error {
                logoutErrorSubject.onNext(error)
            } else {
                logoutPassthroughSubject.onNext(())
            }
        }
    }
}
