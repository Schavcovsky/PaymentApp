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

typealias PaymentTypeDelegate = PaymentTypeViewProtocol

final class PaymentTypePresenter {
    weak var delegate: PaymentTypeViewProtocol?
    private let paymentsMethodsService: PaymentsMethodsServiceProtocol
    
    init(paymentsMethodsService: PaymentsMethodsServiceProtocol = PaymentsMethodsService()) {
        self.paymentsMethodsService = paymentsMethodsService
    }
    
    func fetchPaymentMethods() {
        paymentsMethodsService.getPaymentMethods { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let paymentMethods):
                    // Handle the success case, e.g., store the payment methods, update the UI, etc.
                    self?.delegate?.displayPaymentMethods(paymentMethods: paymentMethods)
                case .failure(let error):
                    // Handle the error case, e.g., show an error message, update the UI, etc.
                    self?.delegate?.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
}
