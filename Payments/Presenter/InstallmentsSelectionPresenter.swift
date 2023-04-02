//
//  InstallmentsSelectionPresenter.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

protocol InstallmentsSelectionViewProtocol: AnyObject {
    func displayInstallments(installments: [Installments.PayerCost])
    func showError(message: String)
    func navigateToAmountEntryViewController(with userSelection: [String])
}

typealias InstallmentsSelectionDelegate = InstallmentsSelectionViewProtocol & UIViewController

final class InstallmentsSelectionPresenter {
    weak var delegate: InstallmentsSelectionViewProtocol?
    let userSelection: UserSelection
    private let paymentsMethodsInstallmentsService: PaymentsMethodsInstallmentsServiceProtocol
    var installments: [Installments.PayerCost] = []
    
    init(userSelection: UserSelection, service: PaymentsMethodsInstallmentsServiceProtocol = PaymentsMethodsInstallmentsService()) {
        self.userSelection = userSelection
        self.paymentsMethodsInstallmentsService = service
    }
    
    func getInstallments() {
        paymentsMethodsInstallmentsService.getPaymentMethodsInstallments(userSelection: userSelection) { [weak self] result in
            switch result {
            case .success(let installments):
                self?.installments = installments.first?.payerCosts ?? []
                self?.delegate?.displayInstallments(installments: self?.installments ?? [])
            case .failure(let error):
                self?.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
}
