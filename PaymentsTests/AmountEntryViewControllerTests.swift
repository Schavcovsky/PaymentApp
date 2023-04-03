//
//  AmountEntryViewControllerTests.swift
//  PaymentsTests
//
//  Created by Alejandro Villalobos on 02-04-23.
//

import XCTest
@testable import Payments

class AmountEntryViewControllerTests: XCTestCase {
    var sut: AmountEntryViewController!
    var presenter: AmountEntryPresenter!
    var userSelection: UserSelection!
    
    override func setUp() {
        super.setUp()
        userSelection = UserSelection()
        presenter = AmountEntryPresenter(userSelection: userSelection)
        sut = AmountEntryViewController(presenter: presenter)
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func testInit_setsPresenter() {
        XCTAssertTrue(sut.presenter === presenter)
    }
    
    func testViewDidLoad_setsPresenterDelegate() {
        sut.viewDidLoad()
        XCTAssertTrue(presenter.delegate === sut)
    }
    
    func testViewDidLoad_errorLabelIsHidden() {
        sut.viewDidLoad()
        XCTAssertTrue(sut.errorLabel.isHidden)
    }
    
    func testViewDidLoad_continueButtonIsDisabled() {
        sut.viewDidLoad()
        XCTAssertFalse(sut.continueButton.isEnabled)
    }
    
    func testUpdateUIForAmount_validAmount_hidesErrorLabel() {
        sut.updateUIForAmount("500")
        XCTAssertTrue(sut.errorLabel.isHidden)
    }
    
    func testUpdateUIForAmount_invalidAmount_showsErrorLabel() {
        sut.updateUIForAmount("-100")
        XCTAssertFalse(sut.errorLabel.isHidden)
    }
    
    func testShowError_setsErrorLabelText() {
        let errorMessage = "Invalid amount"
        sut.showError(message: errorMessage)
        XCTAssertEqual(sut.errorLabel.text, errorMessage)
    }
    
    func testShowError_showsErrorLabel() {
        sut.showError(message: "Invalid amount")
        XCTAssertFalse(sut.errorLabel.isHidden)
    }
    
    func testContinueButtonTapped_resetsAmountTextField() {
        sut.continueButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.amountTextField.text, "")
    }
    
    func testContinueButtonTapped_disablesContinueButton() {
        sut.continueButton.sendActions(for: .touchUpInside)
        XCTAssertFalse(sut.continueButton.isEnabled)
    }
    
    func testViewDidLoad_configuresBackButton() {
        sut.viewDidLoad()
        XCTAssertNotNil(sut.navigationItem.backBarButtonItem)
        XCTAssertEqual(sut.navigationItem.backBarButtonItem?.title, ViewStringConstants.AmountEntry.title)
    }
    
    func testKeyboardWillShow_updatesConstraints() {
        sut.viewDidLoad()
        let initialContinueButtonBottomConstraint = sut.continueButtonBottomConstraint.constant
        let initialAmountTextFieldCenterYConstraint = sut.amountTextFieldCenterYConstraint.constant
        
        let keyboardHeight: CGFloat = 300
        let notification = Notification(name: UIResponder.keyboardWillShowNotification, userInfo: [UIResponder.keyboardFrameEndUserInfoKey: NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: keyboardHeight))])
        
        NotificationCenter.default.post(notification)
        
        XCTAssertNotEqual(sut.continueButtonBottomConstraint.constant, initialContinueButtonBottomConstraint)
        XCTAssertNotEqual(sut.amountTextFieldCenterYConstraint.constant, initialAmountTextFieldCenterYConstraint)
    }
    
    func testKeyboardWillHide_resetsConstraints() {
        sut.viewDidLoad()
        let initialContinueButtonBottomConstraint = sut.continueButtonBottomConstraint.constant
        let initialAmountTextFieldCenterYConstraint = sut.amountTextFieldCenterYConstraint.constant
        
        let showNotification = Notification(name: UIResponder.keyboardWillShowNotification, userInfo: [UIResponder.keyboardFrameEndUserInfoKey: NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: 300))])
        NotificationCenter.default.post(showNotification)
        
        let hideNotification = Notification(name: UIResponder.keyboardWillHideNotification, userInfo: nil)
        NotificationCenter.default.post(hideNotification)
        
        XCTAssertEqual(sut.continueButtonBottomConstraint.constant, initialContinueButtonBottomConstraint)
        XCTAssertEqual(sut.amountTextFieldCenterYConstraint.constant, initialAmountTextFieldCenterYConstraint)
    }
    
    func testDismissKeyboard_dismissesKeyboard() {
        sut.viewDidLoad()
        _ = sut.textFieldShouldReturn(sut.amountTextField)
        XCTAssertFalse(sut.amountTextField.isFirstResponder)
    }
    
    func testOnContinueButtonTapped_presentsAlert() {
        sut.viewDidLoad()
        let expectation = XCTestExpectation(description: "Wait for alert presentation")
        
        // Set a valid amount value
        sut.updateUIForAmount("100")
        
        // Trigger the continue button action
        sut.continueButton.sendActions(for: .touchUpInside)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(self.sut.presentedViewController is UIAlertController)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
