//
//  PaymentTypeViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class PaymentTypeViewController: PaymentTypeDelegate {
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
