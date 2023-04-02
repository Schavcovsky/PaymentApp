//
//  PaymentsMethodsCardIssuerService.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

import Alamofire

// MARK: - PaymentsMethodsCardIssuerServiceProtocol
protocol PaymentsMethodsCardIssuerServiceProtocol {
    func getPaymentMethodsCardIssuer(userSelection: UserSelection, completion: @escaping (_ result: Result<[CardIssuer], Error>) -> Void)
}

class PaymentsMethodsCardIssuerService: NetworkManager, PaymentsMethodsCardIssuerServiceProtocol {
    func getPaymentMethodsCardIssuer(userSelection: UserSelection, completion: @escaping (Result<[CardIssuer], Error>) -> Void) {
        guard let publicKey = PlistHelper.value(forKey: "publicKey", fromPlist: "Environment"),
              let selectedPaymentMethodDict = userSelection.selectedPaymentMethod,
              let selectedPaymentMethod = selectedPaymentMethodDict.first?.key else {
            return
        }
        
        let cleanedPublicKey = publicKey.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedSelectedPaymentMethod = selectedPaymentMethod.trimmingCharacters(in: .whitespacesAndNewlines)

        let urlString = "https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=\(cleanedPublicKey)&payment_method_id=\(cleanedSelectedPaymentMethod)"
               
        NetworkManager.request(url: urlString, httpMethod: .get, expecting: [CardIssuer].self) { result, _, _, _ in
            completion(result)
        }
    }
}

