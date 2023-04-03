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
        guard let publicKey = PlistHelper.value(forKey: "publicKey", fromPlist: "Environment")?.trimmingCharacters(in: .whitespacesAndNewlines),
              let paymentMethodId = userSelection.current.paymentMethodId?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }

        let urlString = APIEndpoint.cardIssuers(paymentMethodId: paymentMethodId).urlString.appending("&public_key=\(publicKey)")
        NetworkManager.request(url: urlString, httpMethod: .get, expecting: [CardIssuer].self) { result, _, _, _ in
            completion(result)
        }
    }
}
