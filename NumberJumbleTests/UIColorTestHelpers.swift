//
//  UIColorExtension.swift
//  NumberJumble
//
//  Created by Remington Davenport on 2/12/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import UIKit
import Nimble

extension UIColor {
    func getColorComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var redValue = CGFloat(0.0), greenValue = CGFloat(0.0), blueValue = CGFloat(0.0), alphaValue = CGFloat(0.0)
        self.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue)
        return (redValue, greenValue, blueValue, alphaValue)
    }
}

public func beSameUIColor(expected: UIColor) -> NonNilMatcherFunc<UIColor> {
    return NonNilMatcherFunc<UIColor> { actualExpression, failureMessage in
        let actualColorComponents = actualExpression.evaluate()!.getColorComponents()
        let expectedColorComponents = expected.getColorComponents()
        
        func closeTo(lhs: CGFloat, rhs: CGFloat) -> Bool {
            let delta = 0.01
            return Double(abs(lhs - rhs)) < delta
        }
        
        return closeTo(actualColorComponents.red, expectedColorComponents.red) &&
                closeTo(actualColorComponents.green, expectedColorComponents.green) &&
                closeTo(actualColorComponents.blue, expectedColorComponents.blue) &&
                closeTo(actualColorComponents.alpha, expectedColorComponents.alpha)
    }
}

