//
//  ConfirmPaymentPresenter.swift
//  Payments
//
//  Created by Alejandro Villalobos on 02-04-23.
//

import UIKit

protocol ConfirmPaymentViewProtocol: AnyObject {
    func confirmTransaction()
}

typealias ConfirmPaymentDelegate = ConfirmPaymentViewProtocol & UIViewController

final class ConfirmPaymentPresenter {
    weak var delegate: ConfirmPaymentViewProtocol?
    let userSelection: UserSelection
    
    init(userSelection: UserSelection) {
        self.userSelection = userSelection
    }
}
