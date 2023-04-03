//
//  PaymentsMethodsService.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import Alamofire

// MARK: - PaymentMethodsServiceProtocol
protocol PaymentsMethodsServiceProtocol {
    func getPaymentMethods(completion: @escaping (_ result: Result<[PaymentMethod], Error>) -> Void)
}

class PaymentsMethodsService: NetworkManager, PaymentsMethodsServiceProtocol {
    func getPaymentMethods(completion: @escaping (Result<[PaymentMethod], Error>) -> Void) {
        guard let publicKey = PlistHelper.value(forKey: "publicKey", fromPlist: "Environment")?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        
        let urlString = "https://api.mercadopago.com/v1/payment_methods?public_key=\(publicKey)"

        NetworkManager.request(url: urlString, httpMethod: .get, expecting: [PaymentMethod].self) { result, _, _, _ in
            completion(result)
        }
    }
}
