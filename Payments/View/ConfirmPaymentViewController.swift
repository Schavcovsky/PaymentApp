//
//  ConfirmPaymentViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 02-04-23.
//

import UIKit

class ConfirmPaymentViewController: ConfirmPaymentDelegate, ViewSetupProtocol {
    private let presenter: ConfirmPaymentPresenter
    private lazy var paymentCardFlowView = makePaymentCardFlow()
    private lazy var continueButton = makeContinueButton()
    
    init(presenter: ConfirmPaymentPresenter) {
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
    
    func confirmTransaction() {
        
    }
}

// MARK: - Setting up UI
extension ConfirmPaymentViewController {
    private func makePaymentCardFlow() -> PaymentCardFlowView {
        let view = PaymentCardFlowView(title: "Estas recargando", userSelection: presenter.userSelection, displayOption: .amountPaymentMethodBankInstallment)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func makeContinueButton() -> PaymentsButton {
        let button = PaymentsButton(type: .system)
        button.setTitle("Confirmar", for: .normal)
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }
    
    func setupViews() {
        view.addSubview(paymentCardFlowView)
        view.addSubview(continueButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            paymentCardFlowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            paymentCardFlowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            paymentCardFlowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension ConfirmPaymentViewController {
    @objc private func continueButtonTapped() {
        for viewController in navigationController?.viewControllers ?? [] {
            if let amountEntryVC = viewController as? AmountEntryViewController {
                navigationController?.popToViewController(amountEntryVC, animated: true)
                amountEntryVC.actionDelegate?.onContinueButtonTapped()
                break
            }
        }
    }
}
