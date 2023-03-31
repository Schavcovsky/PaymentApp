//
//  BankSelectionPresenter.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

protocol BankSelectionViewProtocol: AnyObject {
    func displayBanks(banks: [PaymentMethod])
    func showError(message: String)
    func navigateToInstallmentSelectionViewController()
}

typealias BankSelectionDelegate = BankSelectionViewProtocol & UIViewController

final class BankSelectionPresenter {
    weak var delegate: BankSelectionViewProtocol?
    
}
