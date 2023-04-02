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
    private lazy var paymentCardFlowView = makePaymentCardFlow()
    private lazy var banksTableView = makeBanksTableView()

    init(presenter: BankSelectionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        presenter.delegate = self
        presenter.fetchPaymentMethodCardIssuer()
    }
    
    // MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell", for: indexPath) as! BankTableViewCell
        let bank = banks[indexPath.row]
        cell.configure(with: bank)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBank = banks[indexPath.row]
        presenter.userSelection.selectedBank = [selectedBank.id: selectedBank.name]
        presenter.delegate?.navigateToInstallmentSelectionViewController()
    }

    // MARK: - UITableViewDelegate methods
    // Add any UITableViewDelegate methods you need here

    // MARK: - BankSelectionDelegate methods
    func displayBanks(banks: [CardIssuer]) {
        self.banks = banks
        banksTableView.reloadData()
    }

    func showError(message: String) {
        // Handle error display
    }

    func navigateToInstallmentSelectionViewController() {
        let installmentsSelectionPresenter = InstallmentsSelectionPresenter(userSelection: presenter.userSelection)
        let installmentsSelectionViewController = InstallmentsSelectionViewController(presenter: installmentsSelectionPresenter)
        navigationController?.pushViewController(installmentsSelectionViewController, animated: true)
    }
}

// MARK: - Setting up UI
extension BankSelectionViewController {
    private func makePaymentCardFlow() -> PaymentCardFlowView {
        let view = PaymentCardFlowView(title: "Estas cargando", userSelection: presenter.userSelection, displayOption: .amountPaymentMethod)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func makeBanksTableView() -> PaymentsTableView {
        let tableView = PaymentsTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BankTableViewCell.self, forCellReuseIdentifier: "BankCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }

    // MARK: - ViewSetupProtocol methods
    func setupViews() {
        view.addSubview(paymentCardFlowView)
        view.addSubview(banksTableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            paymentCardFlowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            paymentCardFlowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            paymentCardFlowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            paymentCardFlowView.heightAnchor.constraint(equalToConstant: 120),

            banksTableView.topAnchor.constraint(equalTo: paymentCardFlowView.bottomAnchor, constant: 16),
            banksTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            banksTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            banksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
