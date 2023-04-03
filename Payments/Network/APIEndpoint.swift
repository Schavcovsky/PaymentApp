//
//  APIEndpoint.swift
//  Payments
//
//  Created by Alejandro Villalobos on 02-04-23.
//

enum APIEndpoint {
    case paymentMethods
    case cardIssuers(paymentMethodId: String)
    case installments(publicKey: String, amount: String, paymentMethodId: String, issuerId: String)

    var urlString: String {
        let baseURL = "https://api.mercadopago.com/v1/payment_methods"
        switch self {
        case .paymentMethods:
            return "\(baseURL)"
        case .cardIssuers(let paymentMethodId):
            return "\(baseURL)/card_issuers?payment_method_id=\(paymentMethodId)"
        case .installments(let publicKey, let amount, let paymentMethodId, let issuerId):
            return "\(baseURL)/installments?public_key=\(publicKey)&amount=\(amount)&payment_method_id=\(paymentMethodId)&issuer.id=\(issuerId)"
        }
    }
}
