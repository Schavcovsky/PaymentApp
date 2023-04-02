//
//  Strings+ MoneyFormatting.swift
//  Payments
//
//  Created by Alejandro Villalobos on 02-04-23.
//

import Foundation

extension String {
    func formatAsMoney() -> String {
        // Remove all non-digit characters except for the decimal separator
        let regex = try! NSRegularExpression(pattern: "[^0-9.]+")
        let cleanedInput = regex.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: self.count), withTemplate: "")
        
        // Split the input string into integer and decimal parts
        let components = cleanedInput.components(separatedBy: ".")
        let integerPart = components[0]
        
        // Format the integer part by adding thousands separators
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        let formattedIntegerPart = numberFormatter.string(from: NSNumber(value: Int(integerPart) ?? 0))
        
        // Get the decimal part if it exists, and ensure it has exactly two decimal places
        let decimalPart: String
        if components.count > 1 {
            let decimalValue = Double("0." + components[1]) ?? 0.0
            decimalPart = String(String(format: "%.2f", decimalValue).dropFirst(1)) // Remove the leading 0
        } else {
            decimalPart = ".00"
        }
        
        // Combine the formatted integer part and the decimal part
        let formattedInput = "$ " + (formattedIntegerPart ?? "") + decimalPart
        
        return formattedInput
    }
}
