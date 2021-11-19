//
//  UIViewExtension.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 19/11/21.
//

import Foundation
import UIKit

extension UIView {
    var isRounded: Bool {
        get {
            return self.layer.cornerRadius == self.frame.height * 0.5
        }
        set {
            self.layer.cornerRadius = self.frame.height * 0.5
        }
    }
    
    func setBorder(color: UIColor, strokeWidth: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = strokeWidth
        self.layer.masksToBounds = true
    }
}
