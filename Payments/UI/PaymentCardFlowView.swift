//
//  PaymentCardFlowView.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

import UIKit

class PaymentCardFlowView: UIView {
    let userSelection: UserSelection
    let displayOption: DisplayOption
    
    enum DisplayOption {
        case amount
        case amountPaymentMethod
        case amountPaymentMethodBank
        case amountPaymentMethodBankInstallment
    }
    
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
        stackView.spacing = 28
        return stackView
    }()
    
    init(title: String, userSelection: UserSelection, displayOption: DisplayOption) {
        self.userSelection = userSelection
        self.displayOption = displayOption
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
        let amountItem = createItemCell(title: "Monto", value: userSelection.amount.map { "\($0)".formatAsMoney() })
        let paymentMethodItem = createItemCell(title: "Método de Pago", value: userSelection.paymentMethodName)
        let bankItem = createItemCell(title: "Banco", value: userSelection.bankName)
        let installmentsItem = createItemCell(title: "Cuotas", value: userSelection.selectedInstallment)
        let amountInterestItem = createItemCell(title: "Monto Total", value: userSelection.amountInterest.map { "\($0)".formatAsMoney() })

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        switch displayOption {
        case .amount:
            if let _ = userSelection.amount {
                stackView.addArrangedSubview(amountItem)
            }
        case .amountPaymentMethod:
            if let _ = userSelection.amount {
                stackView.addArrangedSubview(amountItem)
            }
            if let _ = userSelection.paymentMethodId {
                stackView.addArrangedSubview(paymentMethodItem)
            }
        case .amountPaymentMethodBank:
            if let _ = userSelection.amount {
                stackView.addArrangedSubview(amountItem)
            }
            if let _ = userSelection.paymentMethodId {
                stackView.addArrangedSubview(paymentMethodItem)
            }
            if let _ = userSelection.bankId {
                stackView.addArrangedSubview(bankItem)
            }
        case .amountPaymentMethodBankInstallment:
            if let _ = userSelection.amount {
                stackView.addArrangedSubview(amountItem)
            }
            if let _ = userSelection.paymentMethodId {
                stackView.addArrangedSubview(paymentMethodItem)
            }
            if let _ = userSelection.bankId {
                stackView.addArrangedSubview(bankItem)
            }
            if let selectedInstallment = userSelection.selectedInstallment, Int(selectedInstallment) ?? 0 > 1 {
                stackView.addArrangedSubview(installmentsItem)
                if let _ = userSelection.amountInterest {
                    stackView.addArrangedSubview(amountInterestItem)
                }
            }
        }
    }
    
    private func createItemCell(title: String, value: String?) -> UIView {
        let containerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .darkGray
        titleLabel.text = title
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.textColor = .black
        valueLabel.text = value?.capitalized
        
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
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
