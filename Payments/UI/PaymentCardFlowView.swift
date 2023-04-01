//
//  PaymentCardFlowView.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

import UIKit

class PaymentCardFlowView: UIView {
    let userSelection: UserSelection

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    init(title: String, userSelection: UserSelection) {
        self.userSelection = userSelection
        super.init(frame: .zero)
        titleLabel.text = title
        setupViewHierarchy()
        setupConstraints()
        updateData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData() {
        let amountItem = createItemCell(title: "Amount", value: userSelection.amount.map { "$\($0)" })
        let paymentMethodItem = createItemCell(title: "Payment Method", value: userSelection.selectedPaymentMethod)
        let bankItem = createItemCell(title: "Bank", value: userSelection.selectedBank)
        let installmentsItem = createItemCell(title: "Installments", value: userSelection.selectedInstallment)
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if let amount = userSelection.amount {
            stackView.addArrangedSubview(amountItem)
        }
        
        if let paymentMethod = userSelection.selectedPaymentMethod {
            stackView.addArrangedSubview(paymentMethodItem)
        }
        
        if let bank = userSelection.selectedBank {
            stackView.addArrangedSubview(bankItem)
        }
        
        if let installments = userSelection.selectedInstallment {
            stackView.addArrangedSubview(installmentsItem)
        }
    }
    
    private func createItemCell(title: String, value: String?) -> UIView {
        let containerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.text = title
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.textColor = .black
        valueLabel.text = value
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        return containerView
    }
    
    private func setupViewHierarchy() {
        addSubview(titleLabel)
        addSubview(stackView)
        
        
        layer.cornerRadius = 8
        backgroundColor = .systemGray5
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
