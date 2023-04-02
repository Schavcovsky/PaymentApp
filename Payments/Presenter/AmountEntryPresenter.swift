//
//  AmountEntryPresenter.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

protocol AmountEntryViewProtocol: AnyObject {
    func showError(message: String)
    func navigateToPaymentTypeViewController()
}

typealias AmountEntryDelegate = AmountEntryViewProtocol & UIViewController

final class AmountEntryPresenter {
    weak var delegate: AmountEntryViewProtocol?
    let userSelection: UserSelection
    var amount: Double?
    
    init(userSelection: UserSelection) {
        self.userSelection = userSelection
    }
    
    func isValidAmount() -> Bool {
        return self.amount ?? 0.0 >= 1000
    }
    
    func saveAmount() {
        userSelection.amount = Double(self.amount ?? 0.0)
    }
}
