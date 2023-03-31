//
//  CardNumber.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

struct CardNumber: Codable {
    let validation: Validation
    let length: Int
}

enum Validation: String, Codable {
    case none = "none"
    case standard = "standard"
}
