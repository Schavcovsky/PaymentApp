//
//  PaymentTypePresenter.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

protocol PaymentTypeViewProtocol: AnyObject {
    func displayPaymentMethods(paymentMethods: [PaymentMethod])
    func showError(message: String)
    func navigateToBankSelectionViewController()
}

typealias PaymentTypeDelegate = PaymentTypeViewProtocol & UIViewController

final class PaymentTypePresenter {
    weak var delegate: PaymentTypeViewProtocol?
    
}
