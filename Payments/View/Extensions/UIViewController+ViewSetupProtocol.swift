//
//  UIViewController+ViewSetupProtocol.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

import UIKit

protocol ViewSetupProtocol: AnyObject {
    func setupViews()
    func setupConstraints()
}

extension ViewSetupProtocol where Self: UIViewController {
    func setupViewHierarchy() {
        view.backgroundColor = .systemGray6
        setupViews()
        setupConstraints()
    }
}
