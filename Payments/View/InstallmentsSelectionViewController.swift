//
//  InstallmentsSelectionViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class InstallmentsSelectionViewController: InstallmentsSelectionDelegate, ViewSetupProtocol {
    private let presenter: InstallmentsSelectionPresenter
    private lazy var paymentCardFlowView = makePaymentCardFlow()

    init(presenter: InstallmentsSelectionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
    }
    
    func displayInstallments(installments: [Int]) {
        
    }
    
    func showError(message: String) {
        
    }
    
    func navigateToAmountEntryViewController(with userSelection: [String]) {
        
    }
}

// MARK: - Setting up UI
extension InstallmentsSelectionViewController {
    private func makePaymentCardFlow() -> PaymentCardFlowView {
        let view = PaymentCardFlowView(title: "Estas cargando", userSelection: presenter.userSelection, displayOption: .amountPaymentMethodBank)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func setupViews() {
        view.addSubview(paymentCardFlowView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            paymentCardFlowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            paymentCardFlowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            paymentCardFlowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            paymentCardFlowView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
}
