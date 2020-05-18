//
//  FirebaseAuthServiceMock.swift
//  VPlanTests
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import FirebaseAuth
@testable import VPlan

enum MockError: Error {
    case genericError
    case invalidField
    case errorInLogout
    case errorUserInfo
}

struct FirebaseAuthMockService: CreatableAuthFirebaseService {
    
    static let sutUID = "SutUID"
    
    static let emailSut = "sut@gmail.com"
    static let nameSut = "SutUsername"
    
    func didRegisterUser(name: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if name.count < 3 {return completion(.failure(MockError.genericError))}
        
        if email.fieldIsValid(typeField: .email) && password.fieldIsValid(typeField: .password) {return completion(.failure(MockError.invalidField))}
        
        completion(.success(()))
    }
    
    func didLogin(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if email.fieldIsValid(typeField: .email) && password.fieldIsValid(typeField: .password) {return completion(.failure(MockError.invalidField))}
        completion(.success(()))
    }
    
    func sendToResetPassword(email: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        if email.fieldIsValid(typeField: .email) {return onError(MockError.invalidField)}
        onSuccess()
    }
    
    func getCurrentUserUID() -> String {
        return FirebaseAuthMockService.sutUID
    }
    
    func didLogoutUser(completion: (Error?) -> Void) {
        if getCurrentUserUID() == "" {completion(MockError.errorInLogout)}
    }
    
    func getUserInfo(completion: @escaping (Result<((email: String, name: String)), Error>) -> Void) {
        if getCurrentUserUID() == "" {return completion(.failure(MockError.errorUserInfo))}
        
        completion(.success(((email: FirebaseAuthMockService.emailSut, name: FirebaseAuthMockService.nameSut))))
    }
}
