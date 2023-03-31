//
//  SecurityCode.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

struct SecurityCode: Codable {
    let length: Int
    let cardLocation: CardLocation
    let mode: Mode

    enum CodingKeys: String, CodingKey {
        case length
        case cardLocation = "card_location"
        case mode
    }
}

enum CardLocation: String, Codable {
    case back = "back"
    case front = "front"
}

enum Mode: String, Codable {
    case mandatory = "mandatory"
    case modeOptional = "optional"
}

enum Status: String, Codable {
    case active = "active"
}
