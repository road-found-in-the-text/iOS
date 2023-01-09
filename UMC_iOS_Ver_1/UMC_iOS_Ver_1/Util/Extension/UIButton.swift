//
//  UIButton.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/01/07.
//

import UIKit

// MARK: UIButton 내에 Indicator 표시
extension UIButton {
    func showIndicator() {
        let indicator = UIActivityIndicatorView()
        let buttonHeight = self.bounds.size.height
        let buttonWidth = self.bounds.size.width
        indicator.center = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)
        self.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func dismissIndicator() {
        for view in self.subviews {
            if let indicator = view as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
    
    func setUnderline() {
            guard let title = title(for: .normal) else { return }
            let attributedString = NSMutableAttributedString(string: title)
            attributedString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: title.count)
            )
            setAttributedTitle(attributedString, for: .normal)
        }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
            UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
            guard let context = UIGraphicsGetCurrentContext() else { return }
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
            
            let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
             
            self.setBackgroundImage(backgroundImage, for: state)
        }
}
