//
//  AmountTextField.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

enum InputType {
    case text
    case double
}

class PaymentAmountTextField: UITextField {
    var inputType: InputType = .text {
        didSet {
            updateKeyboardType()
        }
    }
    
    var onAmountChanged: ((Double) -> Void)?

    var numericAmount: Double {
        guard let text = text else { return 0 }
        let numericString = text.filter { $0.isNumber }
        return Double(numericString) ?? 0.0
    }
    
    var placeholderText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        borderStyle = .roundedRect
        placeholder = placeholderText
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        updateKeyboardType()
    }
    
    private func updateKeyboardType() {
        switch inputType {
        case .text:
            keyboardType = .default
        case .double:
            keyboardType = .numberPad
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if inputType == .double {
            let numericString = text.filter { $0.isNumber }
            if let firstChar = numericString.first, firstChar == "0" {
                textField.text = String(numericString.dropFirst())
            } else {
                textField.text = formatAsMoney(numericString: numericString)
            }
            onAmountChanged?(numericAmount)
        } else {
            let filteredText = text.filter { $0.isLetter || $0.isWhitespace }
            if text != filteredText {
                textField.text = filteredText
            }
        }
    }
    
    private func formatAsMoney(numericString: String) -> String {
        guard let intValue = Double(numericString) else { return "" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.groupingSize = 3
        guard let formattedNumber = formatter.string(from: NSNumber(value: intValue)) else { return "$ 0" }
        return "$ \(formattedNumber)"
    }
}
