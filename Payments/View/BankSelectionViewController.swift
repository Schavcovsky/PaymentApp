//
//  BankSelectionViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class BankSelectionViewController: BankSelectionDelegate, ViewSetupProtocol, UITableViewDataSource, UITableViewDelegate {
    private let presenter: BankSelectionPresenter
    private var banks: [CardIssuer] = []
    private lazy var activityIndicator = makeActivityIndicator()
    private lazy var errorLabel = makeErrorLabel()
    private lazy var paymentCardFlowView = makePaymentCardFlow()
    private lazy var banksTableView = makeBanksTableView()
    private var bankTableViewHeightConstraint: NSLayoutConstraint?
    private var banksTableViewBottomConstraint: NSLayoutConstraint?

    init(presenter: BankSelectionPresenter) {
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
        presenter.fetchPaymentMethodCardIssuer()
        configureBackButton()
    }
    
    private func configureBackButton() {
        let backButton = UIBarButtonItem(title: "Banco", style: .plain, target: nil, action: nil)
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
        return banks.count
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell", for: indexPath) as! BankTableViewCell
        let bank = banks[indexPath.row]
        cell.configure(with: bank)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBank = banks[indexPath.row]
        presenter.userSelection.updateBank(id: selectedBank.id, name: selectedBank.name)
        presenter.delegate?.navigateToInstallmentSelectionViewController()
    }

    // MARK: - BankSelectionDelegate methods
    func displayBanks(banks: [CardIssuer]) {
        hideActivityIndicator()
        self.banks = banks
        banksTableView.reloadData()
        self.updateTableViewHeight()
    }

    func showError(message: String) {
        hideActivityIndicator()
        paymentCardFlowView.isHidden = true
        errorLabel.text = message
        errorLabel.isHidden = false
    }

    func navigateToInstallmentSelectionViewController() {
        let installmentsSelectionPresenter = InstallmentsSelectionPresenter(userSelection: presenter.userSelection)
        let installmentsSelectionViewController = InstallmentsSelectionViewController(presenter: installmentsSelectionPresenter)
        navigationController?.pushViewController(installmentsSelectionViewController, animated: true)
    }
}

// MARK: - Setting up UI
extension BankSelectionViewController {
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
        let view = PaymentCardFlowView(title: "Estas recargando", userSelection: presenter.userSelection, displayOption: .amountPaymentMethod)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func makeBanksTableView() -> PaymentsTableView {
        let tableView = PaymentsTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BankTableViewCell.self, forCellReuseIdentifier: "BankCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }
    
    // MARK: - ViewSetupProtocol methods
    func setupViews() {
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
        view.addSubview(paymentCardFlowView)
        view.addSubview(banksTableView)
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
            
            banksTableView.topAnchor.constraint(equalTo: paymentCardFlowView.bottomAnchor, constant: 16),
            banksTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            banksTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        banksTableViewBottomConstraint = banksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        banksTableViewBottomConstraint?.priority = .defaultLow
        banksTableViewBottomConstraint?.isActive = true
        
        bankTableViewHeightConstraint = banksTableView.heightAnchor.constraint(equalToConstant: 0)
        bankTableViewHeightConstraint?.isActive = true
    }

    private func updateTableViewHeight() {
        DispatchQueue.main.async {
            let remainingSpace = self.view.frame.height - self.paymentCardFlowView.frame.maxY - 16
            if self.banksTableView.contentSize.height < remainingSpace {
                self.bankTableViewHeightConstraint?.constant = self.banksTableView.contentSize.height
            } else {
                self.bankTableViewHeightConstraint?.constant = remainingSpace
            }
            self.view.layoutIfNeeded()
        }
    }
}
