//
//  PaymentTypeViewController.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class PaymentTypeViewController: UIViewController, PaymentTypeDelegate, ViewSetupProtocol, UITableViewDataSource, UITableViewDelegate {
    private let presenter: PaymentTypePresenter
    private var paymentMethods: [PaymentMethod] = []
    private lazy var paymentCardFlowView = makePaymentCardFlow()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PaymentMethodTableViewCell.self, forCellReuseIdentifier: "PaymentMethodCell")
        return tableView
    }()
    
    init(presenter: PaymentTypePresenter) {
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
        presenter.fetchPaymentMethods()
    }
    
    // MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodTableViewCell
        let paymentMethod = paymentMethods[indexPath.row]
        cell.configure(with: paymentMethod)
        return cell
    }
    
    // MARK: - UITableViewDelegate methods
    // Add any UITableViewDelegate methods you need here

    // MARK: - PaymentTypeDelegate methods
    func displayPaymentMethods(paymentMethods: [PaymentMethod]) {
        self.paymentMethods = paymentMethods
        tableView.reloadData()
    }
    
    func showError(message: String) {
        // Handle error display
    }
    
    func navigateToBankSelectionViewController() {
        // Handle navigation
    }
    
}

// MARK: - Setting up UI
extension PaymentTypeViewController {
    private func makePaymentCardFlow() -> PaymentCardFlowView {
        let view = PaymentCardFlowView(title: "Estas cargando", userSelection: presenter.userSelection)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    // MARK: - ViewSetupProtocol methods
    func setupViews() {
        view.addSubview(paymentCardFlowView)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            paymentCardFlowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            paymentCardFlowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            paymentCardFlowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            paymentCardFlowView.heightAnchor.constraint(equalToConstant: 80),

            tableView.topAnchor.constraint(equalTo: paymentCardFlowView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
