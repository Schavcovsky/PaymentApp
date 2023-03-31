//
//  InstallmentSelectionPresenter.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

protocol InstallmentSelectionViewProtocol: AnyObject {
    func displayInstallments(installments: [Int])
    func showError(message: String)
    func navigateToAmountEntryViewController(with userSelection: [String])
}

typealias InstallmentSelectionDelegate = InstallmentSelectionViewProtocol & UIViewController

final class InstallmentSelectionPresenter {
    weak var delegate: BankSelectionViewProtocol?
    
}
