//
//  PaymentsMethodsService.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import Foundation
import Alamofire

// MARK: - PaymentsMethodsServiceProtocol
protocol PaymentsMethodsServiceProtocol {
    func getPaymentMethods(completion: @escaping (_ result: Result<[PaymentMethod], Error>) -> Void)
}

class PaymentsMethodsService: NetworkManager, PaymentsMethodsServiceProtocol {
    func getPaymentMethods(completion: @escaping (Result<[PaymentMethod], Error>) -> Void) {
        guard let publicKey = PlistHelper.value(forKey: "publicKey", fromPlist: "Environment") else {
            return
        }
        
        let cleanedPublicKey = publicKey.trimmingCharacters(in: .whitespacesAndNewlines)
        let urlString = "https://api.mercadopago.com/v1/payment_methods?public_key=\(cleanedPublicKey)"

        NetworkManager.request(url: urlString, httpMethod: .get, expecting: [PaymentMethod].self) { result, _, _, _ in
            completion(result)
        }
    }
}
