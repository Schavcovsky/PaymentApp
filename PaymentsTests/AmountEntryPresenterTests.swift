//
//  AmountEntryPresenterTests.swift
//  PaymentsTests
//
//  Created by Alejandro Villalobos on 02-04-23.
//

import XCTest
@testable import Payments

class AmountEntryPresenterTests: XCTestCase {
    var presenter: AmountEntryPresenter!
    var userSelection: UserSelection!
    
    override func setUp() {
        super.setUp()
        userSelection = UserSelection()
        presenter = AmountEntryPresenter(userSelection: userSelection)
    }
    
    override func tearDown() {
        presenter = nil
        userSelection = nil
        super.tearDown()
    }
    
    func testIsValidAmount() {
        // Test valid amount
        presenter.amount = "1000"
        XCTAssertTrue(presenter.isValidAmount(), "Valid amount not identified correctly")
        
        presenter.amount = "500"
        XCTAssertTrue(presenter.isValidAmount(), "Valid amount not identified correctly")
        
        // Test invalid amount (too low)
        presenter.amount = "499"
        XCTAssertFalse(presenter.isValidAmount(), "Invalid amount not identified correctly")
        
        // Test invalid amount (too low)
        presenter.amount = "300"
        XCTAssertFalse(presenter.isValidAmount(), "Invalid amount not identified correctly")
        
        presenter.amount = "2500000"
        XCTAssertTrue(presenter.isValidAmount(), "Invalid amount not identified correctly")
    
        // Test invalid amount (too high)
        presenter.amount = "2500001"
        XCTAssertFalse(presenter.isValidAmount(), "Invalid amount not identified correctly")
        
        // Test invalid amount (too high)
        presenter.amount = "3000000"
        XCTAssertFalse(presenter.isValidAmount(), "Invalid amount not identified correctly")
        
        // Test invalid amount (non-numeric)
        presenter.amount = "abc"
        XCTAssertFalse(presenter.isValidAmount(), "Invalid amount not identified correctly")
        
        // Test invalid amount (non-numeric)
        presenter.amount = "!#$$"
        XCTAssertFalse(presenter.isValidAmount(), "Invalid amount not identified correctly")
        
        // Test invalid amount (non-numeric)
        presenter.amount = "123!"
        XCTAssertFalse(presenter.isValidAmount(), "Invalid amount not identified correctly")
        
        // Test invalid amount (non-numeric)
        presenter.amount = "93727."
        XCTAssertFalse(presenter.isValidAmount(), "Invalid amount not identified correctly")
    }
    
    // More test cases
}
