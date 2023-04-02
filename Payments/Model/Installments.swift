//
//  Installments.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

// MARK: - CardIssuerElement
struct Installments: Codable {
    let paymentMethodID, paymentTypeID: String
    let issuer: Issuer
    let processingMode: String
    let payerCosts: [PayerCost]

    enum CodingKeys: String, CodingKey {
        case paymentMethodID = "payment_method_id"
        case paymentTypeID = "payment_type_id"
        case issuer
        case processingMode = "processing_mode"
        case payerCosts = "payer_costs"
    }
    
    // MARK: - Issuer
    struct Issuer: Codable {
        let id, name: String
        let secureThumbnail, thumbnail: String

        enum CodingKeys: String, CodingKey {
            case id, name
            case secureThumbnail = "secure_thumbnail"
            case thumbnail
        }
    }

    // MARK: - PayerCost
    struct PayerCost: Codable {
        let installments: Int
        let installmentRate: Double
        let discountRate: Int
        let labels, installmentRateCollector: [String]
        let minAllowedAmount, maxAllowedAmount: Int
        let recommendedMessage: String
        let installmentAmount, totalAmount: Double
        let paymentMethodOptionID: String

        enum CodingKeys: String, CodingKey {
            case installments
            case installmentRate = "installment_rate"
            case discountRate = "discount_rate"
            case labels
            case installmentRateCollector = "installment_rate_collector"
            case minAllowedAmount = "min_allowed_amount"
            case maxAllowedAmount = "max_allowed_amount"
            case recommendedMessage = "recommended_message"
            case installmentAmount = "installment_amount"
            case totalAmount = "total_amount"
            case paymentMethodOptionID = "payment_method_option_id"
        }
    }
}

