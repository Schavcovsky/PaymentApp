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
        guard let publicKey = PlistHelper.value(forKey: "publicKey",
                                                fromPlist: "Environment"),
              let selectedAmount = userSelection.amount,
              let selectedPaymentMethodId = userSelection.paymentMethodId,
              let selectedBank = userSelection.bankId
        else {
            return
        }
        
        let cleanedPublicKey = publicKey.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedSelectedPaymentMethodId = selectedPaymentMethodId.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedSelectedPaymentBank = selectedBank.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let urlString = "https://api.mercadopago.com/v1/payment_methods/installments?public_key=\(cleanedPublicKey)&amount=\(selectedAmount)&payment_method_id=\(cleanedSelectedPaymentMethodId)&issuer.id=\(cleanedSelectedPaymentBank)"
        
        print(urlString)
        
        NetworkManager.request(url: urlString, httpMethod: .get, expecting: [Installments].self) { result, _, _, _ in
            completion(result)
        }
    }
}
