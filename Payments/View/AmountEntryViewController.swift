//
//  AmountEntryViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class AmountEntryViewController: AmountEntryDelegate, ViewSetupProtocol, UITextFieldDelegate {
    private let presenter: AmountEntryPresenter
    private lazy var amountTextField = makeAmountTextField()
    private lazy var continueButton = makeContinueButton()
    private lazy var errorLabel = makeErrorLabel()
        
    init(presenter: AmountEntryPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        addGestureRecognizer()
        errorLabel.isHidden = true
    }
    
    func addGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func navigateToPaymentTypeViewController() {
        let paymentTypePresenter = PaymentTypePresenter(userSelection: presenter.userSelection)
        let paymentTypeViewController = PaymentTypeViewController(presenter: paymentTypePresenter)
        navigationController?.pushViewController(paymentTypeViewController, animated: true)
    }
}

// MARK: - Setting up UI
extension AmountEntryViewController {
    private func makeAmountTextField() -> PaymentAmountTextField {
        let textField = PaymentAmountTextField()
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.placeholder = ViewStringConstants.AmountEntry.amountPlaceholder
        textField.inputType = .integer
        textField.delegate = self
        textField.onAmountChanged = { [weak self] amount in
            guard let self = self else { return }
            self.presenter.amount = amount
            self.continueButton.isEnabled = self.presenter.isValidAmount()
            self.errorLabel.isHidden = self.presenter.isValidAmount()
        }
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func makeContinueButton() -> PaymentsButton {
        let button = PaymentsButton(type: .system)
        button.setTitle(ViewStringConstants.AmountEntry.continueButton, for: .normal)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func makeErrorLabel() -> PaymentsErrorLabel {
        let label = PaymentsErrorLabel()
        label.text = ViewStringConstants.AmountEntry.amountErrorLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setupViews() {
        view.addSubview(amountTextField)
        view.addSubview(continueButton)
        view.addSubview(errorLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            amountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 8),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension AmountEntryViewController {
    @objc private func continueButtonTapped() {
        presenter.saveAmount()
        navigateToPaymentTypeViewController()
    }
}

extension AmountEntryViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
