//
//  UIView + Extension.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
