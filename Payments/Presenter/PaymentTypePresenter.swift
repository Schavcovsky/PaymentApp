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
    let userSelection: UserSelection
    private let paymentsMethodsService: PaymentsMethodsServiceProtocol
    
    init(userSelection: UserSelection, paymentsMethodsService: PaymentsMethodsServiceProtocol = PaymentsMethodsService()) {
        self.userSelection = userSelection
        self.paymentsMethodsService = paymentsMethodsService
    }
    
    func fetchPaymentMethods() {
        paymentsMethodsService.getPaymentMethods { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let paymentMethods):
                    let filteredPaymentMethods = paymentMethods.filter { $0.paymentTypeID == .creditCard }
                    self?.delegate?.displayPaymentMethods(paymentMethods: filteredPaymentMethods)
                case .failure(_):
                    self?.delegate?.showError(message: "Lo sentimos, no se pudieron obtener los datos. Verifique su conexión a Internet y vuelva a intentarlo.")
                }
            }
        }
    }
}
