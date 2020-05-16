//
//  Regex.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 16/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import Foundation

extension String {
    func fieldIsValid(typeField type: TypeValidation) -> Bool {
        switch type {
        case .password:
            let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
            return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
        case .email:
            let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
            return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
        }
    }
}



enum TypeValidation {
    case email
    case password
}
