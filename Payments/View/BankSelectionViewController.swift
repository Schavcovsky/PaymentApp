//
//  BankSelectionViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class BankSelectionViewController: BankSelectionDelegate {
    private let presenter = BankSelectionPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func displayBanks(banks: [PaymentMethod]) {
        
    }
    
    func showError(message: String) {
        
    }
    
    func navigateToInstallmentSelectionViewController() {
        
    }
}
