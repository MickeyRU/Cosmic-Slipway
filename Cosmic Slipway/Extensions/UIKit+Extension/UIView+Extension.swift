//
//  UIView+Extension.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 25.03.2023.
//

import UIKit

extension UIView {
    func addViews(_ view: UIView){
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
