//
//  AmountEntryPresenter.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

protocol AmountEntryViewActionDelegate: AnyObject {
    func onContinueButtonTapped()
}

protocol AmountEntryViewProtocol: AnyObject {
    var actionDelegate: AmountEntryViewActionDelegate? { get set }
    func showError(message: String)
    func navigateToPaymentTypeViewController(viewController: UIViewController)
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
        guard let amount = self.amount else { return false }
        return (500...2500000).contains(amount)
    }
    
    func saveAmount() {
        if let amount = amount {
            let amountString = String(amount)
            userSelection.updateAmount(amountString)
        }
    }
    
    func navigateToPaymentTypeViewController(viewController: UIViewController) {
        let paymentTypePresenter = PaymentTypePresenter(userSelection: userSelection)
        let paymentTypeViewController = PaymentTypeViewController(presenter: paymentTypePresenter)
        
        if let amountEntryVC = viewController as? AmountEntryViewController {
            amountEntryVC.actionDelegate = amountEntryVC
        }
        
        viewController.navigationController?.pushViewController(paymentTypeViewController, animated: true)
    }
}
