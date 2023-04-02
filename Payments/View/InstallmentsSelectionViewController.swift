//
//  InstallmentsSelectionViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class InstallmentsSelectionViewController: InstallmentsSelectionDelegate, ViewSetupProtocol, UITableViewDataSource, UITableViewDelegate {
    private let presenter: InstallmentsSelectionPresenter
    private lazy var paymentCardFlowView = makePaymentCardFlow()
    private lazy var installmentsTableView = makeInstallmentsTableView()

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
        presenter.delegate = self
        presenter.getInstallments()
    }
    
    func displayInstallments(installments: [Installments.PayerCost]) {
        installmentsTableView.reloadData()
    }
    
    func showError(message: String) {
        
    }
    
    func navigateToAmountEntryViewController(with userSelection: [String]) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.installments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstallmentsTableViewCell", for: indexPath) as! InstallmentsTableViewCell
        let payerCost = presenter.installments[indexPath.row]
        cell.configure(with: payerCost)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedInstallment = presenter.installments[indexPath.row]
        presenter.userSelection.selectedInstallment = String(selectedInstallment.installments)
        presenter.userSelection.amountInterest = selectedInstallment.totalAmount
        presenter.delegate?.navigateToBankSelectionViewController()
    }
    
    func navigateToBankSelectionViewController() {
        let confirmPresenter = ConfirmPaymentPresenter(userSelection: presenter.userSelection)
        let confirmSelectionViewController = ConfirmPaymentViewController(presenter: confirmPresenter)
        navigationController?.pushViewController(confirmSelectionViewController, animated: true)
    }
}

// MARK: - Setting up UI
extension InstallmentsSelectionViewController {
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

    func setupViews() {
        view.addSubview(paymentCardFlowView)
        view.addSubview(installmentsTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            paymentCardFlowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            paymentCardFlowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            paymentCardFlowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            paymentCardFlowView.heightAnchor.constraint(equalToConstant: 150),
            
            installmentsTableView.topAnchor.constraint(equalTo: paymentCardFlowView.bottomAnchor, constant: 16),
            installmentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            installmentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            installmentsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
