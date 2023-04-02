//
//  PaymentsTableView.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

import UIKit

class PaymentsTableView: UITableView {
    private let cornerRadius: CGFloat = 8

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureTableView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureTableView()
    }

    private func configureTableView() {
        layer.cornerRadius = cornerRadius
    }
}
