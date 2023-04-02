//
//  PaymentsMethodsInstallmentsService.swift.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

import Alamofire

// MARK: - PaymentsMethodsCardIssuerServiceProtocol
protocol PaymentsMethodsInstallmentsServiceProtocol {
    func getPaymentMethodsInstallments(userSelection: UserSelection, completion: @escaping (_ result: Result<[CardIssuer], Error>) -> Void)
}

class PaymentsMethodsInstallmentsService: NetworkManager, PaymentsMethodsInstallmentsServiceProtocol {
    func getPaymentMethodsInstallments(userSelection: UserSelection, completion: @escaping (Result<[CardIssuer], Error>) -> Void) {
        guard let publicKey = PlistHelper.value(forKey: "publicKey", fromPlist: "Environment"), let selectedPaymentMethod = userSelection.selectedPaymentMethod, let selectedIssuerId = userSelection.selectedBank else {
            return
        }
        
        let cleanedPublicKey = publicKey.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedSelectedPaymentMethod = selectedPaymentMethod.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedSelectedIssuerId = selectedPaymentMethod.trimmingCharacters(in: .whitespacesAndNewlines)

        let urlString = "https://api.mercadopago.com/v1/payment_methods/installments?public_key=\(cleanedPublicKey)&amount=\(cleanedSelectedPaymentMethod)&payment_method_id=\(userSelection.amount)&issuer.id=692"
               
        NetworkManager.request(url: urlString, httpMethod: .get, expecting: [CardIssuer].self) { result, _, _, _ in
            completion(result)
        }
    }
}
