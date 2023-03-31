//
//  Settings.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

struct Setting: Codable {
    let cardNumber: CardNumber
    let bin: Bin
    let securityCode: SecurityCode

    enum CodingKeys: String, CodingKey {
        case cardNumber = "card_number"
        case bin
        case securityCode = "security_code"
    }
}
