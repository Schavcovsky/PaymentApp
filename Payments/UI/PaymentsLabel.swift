//
//  PaymentsLabel.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

import UIKit

class PaymentsErrorLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        font = .systemFont(ofSize: 12)
        textColor = .red
        numberOfLines = 0
        textAlignment = .center
    }
}
