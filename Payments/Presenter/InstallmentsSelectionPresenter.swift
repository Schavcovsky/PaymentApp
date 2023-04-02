//
//  InstallmentsSelectionPresenter.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

protocol InstallmentsSelectionViewProtocol: AnyObject {
    func displayInstallments(installments: [Int])
    func showError(message: String)
    func navigateToAmountEntryViewController(with userSelection: [String])
}

typealias InstallmentsSelectionDelegate = InstallmentsSelectionViewProtocol & UIViewController

final class InstallmentsSelectionPresenter {
    weak var delegate: BankSelectionViewProtocol?
    let userSelection: UserSelection
    private let paymentsMethodsInstallmentsService: PaymentsMethodsInstallmentsServiceProtocol

    init(userSelection: UserSelection, service: PaymentsMethodsInstallmentsServiceProtocol = PaymentsMethodsInstallmentsService()) {
        self.userSelection = userSelection
        self.paymentsMethodsInstallmentsService = service
    }
}
