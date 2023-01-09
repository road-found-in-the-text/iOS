//
//  CustomTextField.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/01/07.
//

import UIKit

//순전히 clear Button 위치 옮기기위해 만든 class
class CustomTextField: UITextField {

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {

            let originalRect = super.clearButtonRect(forBounds: bounds)

            //move 10 points left

            return originalRect.offsetBy(dx: -15, dy: 0)
        }


}
