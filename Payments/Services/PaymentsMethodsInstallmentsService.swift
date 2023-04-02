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
              let selectedPaymentMethod = userSelection.selectedPaymentMethod,
              let selectedIssuerId = userSelection.selectedBank?.first?.key,
              let selectedIssuerName = userSelection.selectedBank?.first?.value,
              let selectedAmount = userSelection.amount
        else {
            return
        }
        
        let cleanedPublicKey = publicKey.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedSelectedPaymentMethod = selectedPaymentMethod.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedSelectedIssuerName = selectedIssuerName.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedSelectedIssuerId = selectedIssuerId.trimmingCharacters(in: .whitespacesAndNewlines)

        let urlString = "https://api.mercadopago.com/v1/payment_methods/installments?public_key=\(cleanedPublicKey)&amount=\(selectedAmount)&payment_method_id=\(cleanedSelectedIssuerName)&issuer.id=\(cleanedSelectedIssuerId)"
        
        print(urlString)
        
        NetworkManager.request(url: urlString, httpMethod: .get, expecting: [Installments].self) { result, _, _, _ in
            completion(result)
        }
    }
}
