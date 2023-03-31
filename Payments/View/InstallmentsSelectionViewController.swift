//
//  InstallmentsSelectionViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class InstallmentsSelectionViewController: InstallmentsSelectionDelegate, ViewSetupProtocol {
    
    private let presenter = InstallmentsSelectionPresenter()

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

// MARK: - Setting up UI
extension InstallmentsSelectionViewProtocol {
    func setupViews() {
        
    }
    
    func setupConstraints() {
    
    }
}
