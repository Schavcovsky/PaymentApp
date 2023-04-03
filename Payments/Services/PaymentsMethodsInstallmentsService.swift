//
//  PaymentsMethodsInstallmentsService.swift.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

import Alamofire

// MARK: - PaymentsMethodsCardIssuerServiceProtocol
protocol PaymentsMethodsInstallmentsServiceProtocol {
    func getPaymentMethodsInstallments(userSelection: UserSelection, completion: @escaping (_ result: Result<[Installments], Error>) -> Void)
}

class PaymentsMethodsInstallmentsService: NetworkManager, PaymentsMethodsInstallmentsServiceProtocol {
    func getPaymentMethodsInstallments(userSelection: UserSelection, completion: @escaping (Result<[Installments], Error>) -> Void) {
        guard let publicKey = PlistHelper.value(forKey: "publicKey", fromPlist: "Environment")?.trimmingCharacters(in: .whitespacesAndNewlines),
              let selectedAmount = userSelection.current.amount,
              let selectedPaymentMethodId = userSelection.current.paymentMethodId?.trimmingCharacters(in: .whitespacesAndNewlines),
              let selectedBank = userSelection.current.bankId?.trimmingCharacters(in: .whitespacesAndNewlines)
        else {
            return
        }
        
        let urlString = "https://api.mercadopago.com/v1/payment_methods/installments?public_key=\(publicKey)&amount=\(selectedAmount)&payment_method_id=\(selectedPaymentMethodId)&issuer.id=\(selectedBank)"
        
        NetworkManager.request(url: urlString, httpMethod: .get, expecting: [Installments].self) { result, _, _, _ in
            completion(result)
        }
    }
}
