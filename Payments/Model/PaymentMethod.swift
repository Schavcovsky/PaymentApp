//
//  PaymentMethod.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import Foundation

struct PaymentMethod: Codable {
    let id, name: String
    let paymentTypeID: PaymentTypeID
    let status: Status
    let secureThumbnail: String
    let thumbnail: String
    let deferredCapture: DeferredCapture
    let settings: [Setting]
    let additionalInfoNeeded: [AdditionalInfoNeeded]
    let minAllowedAmount, maxAllowedAmount, accreditationTime: Int
    let processingModes: [ProcessingMode]

    enum CodingKeys: String, CodingKey {
        case id, name
        case paymentTypeID = "payment_type_id"
        case status
        case secureThumbnail = "secure_thumbnail"
        case thumbnail
        case deferredCapture = "deferred_capture"
        case settings
        case additionalInfoNeeded = "additional_info_needed"
        case minAllowedAmount = "min_allowed_amount"
        case maxAllowedAmount = "max_allowed_amount"
        case accreditationTime = "accreditation_time"
        case processingModes = "processing_modes"
    }
}

enum AdditionalInfoNeeded: String, Codable {
    case cardholderIdentificationNumber = "cardholder_identification_number"
    case cardholderIdentificationType = "cardholder_identification_type"
    case cardholderName = "cardholder_name"
    case issuerID = "issuer_id"
}

enum DeferredCapture: String, Codable {
    case doesNotApply = "does_not_apply"
    case supported = "supported"
    case unsupported = "unsupported"
}

enum PaymentTypeID: String, Codable {
    case creditCard = "credit_card"
    case debitCard = "debit_card"
    case ticket = "ticket"
}

enum ProcessingMode: String, Codable {
    case aggregator = "aggregator"
}
