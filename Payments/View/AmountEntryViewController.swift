//
//  AmountEntryViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class AmountEntryViewController: AmountEntryDelegate, ViewSetupProtocol {
    private let presenter = AmountEntryPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
    }
    
    func showError(message: String) {
        
    }
    
    func navigateToPaymentTypeViewController() {
        
    }
}

// MARK: - Setting up UI
extension AmountEntryViewController {
    func setupViews() {
        
    }
    
    func setupConstraints() {
    
    }
}
