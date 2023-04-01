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
   
    func isValidAmount(_ amount: Int) -> Bool {
        return amount >= 1000
    }
    
}
