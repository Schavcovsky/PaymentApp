//
//  PaymentsButton.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

class PaymentsButton: UIButton {
    private let cornerRadius: CGFloat = 8

    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
                        
    private func configureButton() {
        layer.cornerRadius = cornerRadius
        isEnabled = false
        updateAppearance()
    }
    
    private func updateAppearance() {
        if isEnabled {
            setTitleColor(.white, for: .normal)
            backgroundColor = .systemBlue
        } else {
            setTitleColor(.systemGray, for: .normal)
            backgroundColor = .darkGray
        }
    }
}
