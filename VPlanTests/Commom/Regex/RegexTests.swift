//
//  RegexTests.swift
//  VPlanTests
//
//  Created by Vinicius Mangueira on 18/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import XCTest
@testable import VPlan

class RegexTests: XCTestCase {
    
    let wrongEmailSut = "stubhub"
    
    let rightEmail = "stubhub@gmail.com"

    func testWrongEmailRegex() {
        XCTAssertFalse(self.wrongEmailSut.fieldIsValid(typeField: .email))
    }
    
    func testRightEmailRegex() {
        XCTAssertTrue(self.rightEmail.fieldIsValid(typeField: .email))
    }
    
    func testCasesOfWrongPassword() {
        XCTAssertFalse("stub".fieldIsValid(typeField: .password))
        XCTAssertFalse("stub10".fieldIsValid(typeField: .password))
        XCTAssertFalse("stubstub10".fieldIsValid(typeField: .password))
    }
    
    
    func testRightPassword() {
        XCTAssertTrue("Stubstub10".fieldIsValid(typeField: .password))
    }
}
