//
//  InstallmentsSelectionViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class InstallmentsSelectionViewController: InstallmentsSelectionDelegate, ViewSetupProtocol, UITableViewDataSource, UITableViewDelegate {
    private let presenter: InstallmentsSelectionPresenter
    private lazy var activityIndicator = makeActivityIndicator()
    private lazy var errorLabel = makeErrorLabel()
    private lazy var paymentCardFlowView = makePaymentCardFlow()
    private lazy var installmentsTableView = makeInstallmentsTableView()
    private var installmentsTableViewHeightConstraint: NSLayoutConstraint?
    
    init(presenter: InstallmentsSelectionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        setupViewHierarchy()
        showActivityIndicator()
        presenter.getInstallments()
        configureBackButton()
    }
    
    private func configureBackButton() {
        let backButton = UIBarButtonItem(title: "Cuotas", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.installments.count
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstallmentsTableViewCell", for: indexPath) as! InstallmentsTableViewCell
        let payerCost = presenter.installments[indexPath.row]
        cell.configure(with: payerCost)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedInstallment = presenter.installments[indexPath.row]
        presenter.userSelection.updateInstallmentData(installment: selectedInstallment.installments, totalAmount: String(selectedInstallment.totalAmount))
        presenter.delegate?.navigateToBankSelectionViewController()
    }
    
    // MARK: - InstallmentsSelectionDelegate
    func displayInstallments() {
        hideActivityIndicator()
        installmentsTableView.reloadData()
        updateTableViewHeight()
    }
    
    func showError(message: String) {
        hideActivityIndicator()
        paymentCardFlowView.isHidden = true
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func navigateToBankSelectionViewController() {
        let confirmPresenter = ConfirmPaymentPresenter(userSelection: presenter.userSelection)
        let confirmSelectionViewController = ConfirmPaymentViewController(presenter: confirmPresenter)
        navigationController?.pushViewController(confirmSelectionViewController, animated: true)
    }
}

// MARK: - Setting up UI
extension InstallmentsSelectionViewController {
    private func makeActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }
    
    private func makeErrorLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }
    
    private func makePaymentCardFlow() -> PaymentCardFlowView {
        let view = PaymentCardFlowView(title: "Estas recargando", userSelection: presenter.userSelection, displayOption: .amountPaymentMethodBank)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func makeInstallmentsTableView() -> PaymentsTableView {
        let tableView = PaymentsTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InstallmentsTableViewCell.self, forCellReuseIdentifier: "InstallmentsTableViewCell")
        tableView.backgroundColor = .clear
        return tableView
    }
    
    // MARK: - ViewSetupProtocol methods
    func setupViews() {
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
        view.addSubview(paymentCardFlowView)
        view.addSubview(installmentsTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            paymentCardFlowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            paymentCardFlowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            paymentCardFlowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            installmentsTableView.topAnchor.constraint(equalTo: paymentCardFlowView.bottomAnchor, constant: 16),
            installmentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            installmentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        installmentsTableViewHeightConstraint = installmentsTableView.heightAnchor.constraint(equalToConstant: 0)
        installmentsTableViewHeightConstraint?.isActive = true
    }
    
    private func updateTableViewHeight() {
        DispatchQueue.main.async {
            self.installmentsTableViewHeightConstraint?.constant = self.installmentsTableView.contentSize.height
            self.view.layoutIfNeeded()
        }
    }
}
