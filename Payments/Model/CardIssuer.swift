//
//  CardIssuer.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

import Foundation

// MARK: - CardIssuerElement
struct CardIssuer: Codable {
    let id, name: String
    let secureThumbnail, thumbnail: String
    let processingMode: ProcessingMode
    let status: Status

    enum CodingKeys: String, CodingKey {
        case id, name
        case secureThumbnail = "secure_thumbnail"
        case thumbnail
        case processingMode = "processing_mode"
        case status
    }
    
    enum ProcessingMode: String, Codable {
        case aggregator = "aggregator"
    }

    enum Status: String, Codable {
        case active = "active"
    }

}

