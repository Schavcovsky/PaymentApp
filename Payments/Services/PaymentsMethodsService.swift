//
//  PaymentsMethodsService.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import Foundation

protocol PaymentsMethodsServiceProtocol {
    func getPaymentMethods(completion: @escaping (Result<[PaymentMethod], Error>) -> Void)
}

class PaymentsMethodsService: NetworkManager, PaymentsMethodsServiceProtocol {
    private let publicKey: String
    private let baseURL: String = "https://api.mercadopago.com/v1/payment_methods"

    init(publicKey: String) {
        self.publicKey = publicKey
    }

    func getPaymentMethods(completion: @escaping (Result<[PaymentMethod], Error>) -> Void) {
        let url = "\(baseURL)?public_key=\(publicKey)"
        NetworkManager.request(url: url, httpMethod: .get, expecting: [PaymentMethod].self) { result, _, _, _ in
            completion(result)
        }
    }
}
