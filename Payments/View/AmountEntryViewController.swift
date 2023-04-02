//
//  AmountEntryViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class AmountEntryViewController: AmountEntryDelegate, ViewSetupProtocol, UITextFieldDelegate {
    internal let presenter: AmountEntryPresenter
    private lazy var amountTextField = makeAmountTextField()
    private lazy var continueButton = makeContinueButton()
    private lazy var errorLabel = makeErrorLabel()
    private var continueButtonBottomConstraint: NSLayoutConstraint!
    private var amountTextFieldCenterYConstraint: NSLayoutConstraint!
    weak var actionDelegate: AmountEntryViewActionDelegate?

    init(presenter: AmountEntryPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        presenter.delegate = self
        setupViewHierarchy()
        addGestureRecognizer()
        errorLabel.isHidden = true
        configureBackButton()
        setupNotificationObservers()
    }
    
    deinit {
        removeNotificationObservers()
    }
    
    private func configureBackButton() {
        let backButton = UIBarButtonItem(title: "Inicio", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
        
    func addGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - AmountEntryDelegate
    private func updateUIForAmount(_ amount: String) {
        presenter.amount = amount
        let isValidAmount = presenter.isValidAmount()
        continueButton.isEnabled = isValidAmount
        errorLabel.isHidden = isValidAmount
    }

    func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func navigateToPaymentTypeViewController(viewController: UIViewController) {
        let paymentTypePresenter = PaymentTypePresenter(userSelection: presenter.userSelection)
        let paymentTypeViewController = PaymentTypeViewController(presenter: paymentTypePresenter)
        viewController.navigationController?.pushViewController(paymentTypeViewController, animated: true)

        let amountEntryPresenter = AmountEntryPresenter(userSelection: presenter.userSelection)
        let amountEntryViewController = AmountEntryViewController(presenter: amountEntryPresenter)
        amountEntryViewController.actionDelegate = amountEntryViewController
    }
}

// MARK: - Setting up UI
extension AmountEntryViewController {
    private func makeAmountTextField() -> PaymentAmountTextField {
        let textField = PaymentAmountTextField()
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.placeholder = ViewStringConstants.AmountEntry.amountPlaceholder
        textField.inputType = .integer
        textField.delegate = self
        textField.onAmountChanged = { [weak self] amount in
            self?.updateUIForAmount(String(amount))
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
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        continueButtonBottomConstraint = continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        continueButtonBottomConstraint.isActive = true
        
        amountTextFieldCenterYConstraint = amountTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        amountTextFieldCenterYConstraint.isActive = true
    }
}

extension AmountEntryViewController {
    @objc private func continueButtonTapped() {
        presenter.saveAmount()
        presenter.navigateToPaymentTypeViewController(viewController: self)
        amountTextField.text = nil
        continueButton.isEnabled = false
        dismissKeyboard()
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

extension AmountEntryViewController {
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardFrame.height
            continueButtonBottomConstraint.constant = -keyboardHeight - 16
            amountTextFieldCenterYConstraint.constant = -(keyboardHeight / 2)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        continueButtonBottomConstraint.constant = -16
        amountTextFieldCenterYConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension AmountEntryViewController: AmountEntryViewActionDelegate {
    func onContinueButtonTapped() {
        let alert = UIAlertController(title: "Recarga exitosa", message: userSelectionMessage(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.presenter.userSelection.reset()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func userSelectionMessage() -> String {
        let selection = presenter.userSelection.current
        let amount = selection.amount?.formatAsMoney() ?? "N/A"
        let paymentMethod = selection.paymentMethodName ?? "N/A"
        let bank = selection.bankName ?? "N/A"
        let installment = selection.selectedInstallment.map(String.init) ?? "N/A"
        let amountInterest = selection.amountInterest?.formatAsMoney() ?? "N/A"

        return """
        Monto: \(amount)
        Método de Pago: \(paymentMethod)
        Banco: \(bank)
        Cuotas: \(installment)
        Monto total con interés: \(amountInterest)
        """
    }
}
