//
//  Bin.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

struct Bin: Codable {
    let pattern, installmentsPattern: String
    let exclusionPattern: String?

    enum CodingKeys: String, CodingKey {
        case pattern
        case installmentsPattern = "installments_pattern"
        case exclusionPattern = "exclusion_pattern"
    }
}
