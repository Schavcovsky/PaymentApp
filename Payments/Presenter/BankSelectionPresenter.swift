//
//  BankSelectionPresenter.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

protocol BankSelectionViewProtocol: AnyObject {
    func displayBanks(banks: [CardIssuer])
    func showError(message: String)
    func navigateToInstallmentSelectionViewController()
}

typealias BankSelectionDelegate = BankSelectionViewProtocol & UIViewController

final class BankSelectionPresenter {
    weak var delegate: BankSelectionViewProtocol?
    let userSelection: UserSelection
    private let paymentsMethodsCardIssuerService: PaymentsMethodsCardIssuerServiceProtocol

    init(userSelection: UserSelection, service: PaymentsMethodsCardIssuerServiceProtocol = PaymentsMethodsCardIssuerService()) {
        self.userSelection = userSelection
        self.paymentsMethodsCardIssuerService = service
    }
    
    func fetchPaymentMethodCardIssuer() {
        paymentsMethodsCardIssuerService.getPaymentMethodsCardIssuer(userSelection: userSelection) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let paymentMethodCardIssuer):
                    self?.delegate?.displayBanks(banks: paymentMethodCardIssuer)
                case .failure(let _):
                    self?.delegate?.showError(message: "Lo sentimos, no se pudieron obtener los datos. Verifique su conexión a Internet y vuelva a intentarlo.")
                }
            }
        }
    }
}
