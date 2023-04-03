//
//  MockPaymentTypePresenter.swift
//  PaymentsTests
//
//  Created by Alejandro Villalobos on 02-04-23.
//

import Foundation

protocol PaymentTypePresenterProtocol: AnyObject {
    var delegate: PaymentTypeDelegate? { get set }
    func fetchPaymentMethods()
}

extension PaymentTypePresenter: PaymentTypePresenterProtocol {}

class MockPaymentTypePresenter: PaymentTypePresenterProtocol {
    var delegate: PaymentTypeDelegate?
    var fetchPaymentMethodsCalled = false

    func fetchPaymentMethods() {
        fetchPaymentMethodsCalled = true
    }
}
