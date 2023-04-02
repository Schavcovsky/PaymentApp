//
//  InstallmentsSelectionPresenter.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

// MARK: - InstallmentsSelectionViewProtocol
protocol InstallmentsSelectionViewProtocol: AnyObject {
    func displayInstallments()
    func showError(message: String)
    func navigateToBankSelectionViewController()
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
                self?.delegate?.displayInstallments()
            case .failure(let error):
                self?.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
}
