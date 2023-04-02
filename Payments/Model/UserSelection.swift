//
//  UserSelection.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

struct Selection {
    var amount: String?
    var paymentMethodId: String?
    var paymentMethodName: String?
    var bankId: String?
    var bankName: String?
    var selectedInstallment: Int?
    var amountInterest: String?
}

class UserSelection {
    private(set) var current: Selection
    
    init() {
        current = Selection()
    }
    
    func updateAmount(_ newAmount: String) {
        current.amount = newAmount
    }
    
    func updatePaymentMethod(id: String, name: String) {
        current.paymentMethodId = id
        current.paymentMethodName = name
    }
    
    func updateBank(id: String, name: String) {
        current.bankId = id
        current.bankName = name
    }
    
    func updateInstallmentData(installment: Int, totalAmount: String) {
        current.selectedInstallment = installment
        current.amountInterest = totalAmount
    }
    
    func reset() {
        current = Selection()
    }
}
