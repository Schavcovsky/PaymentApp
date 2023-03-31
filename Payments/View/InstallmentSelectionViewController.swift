//
//  InstallmentSelectionViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class InstallmentSelectionViewController: InstallmentSelectionDelegate {
    
    private let presenter = InstallmentSelectionPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayInstallments(installments: [Int]) {
        
    }
    
    func showError(message: String) {
        
    }
    
    func navigateToAmountEntryViewController(with userSelection: [String]) {
        
    }
}
