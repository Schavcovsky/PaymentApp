//
//  PaymentTypeViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class PaymentTypeViewController: PaymentTypeDelegate, ViewSetupProtocol {
    private let presenter = PaymentTypePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayPaymentMethods(paymentMethods: [PaymentMethod]) {
        
    }
    
    func showError(message: String) {
        
    }
    
    func navigateToBankSelectionViewController() {
        
    }
}

// MARK: - Setting up UI
extension PaymentTypeViewController {
    func setupViews() {
        
    }
    
    func setupConstraints() {
    
    }
}
