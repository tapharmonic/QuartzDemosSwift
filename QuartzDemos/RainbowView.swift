//
//  MIT License
//
//  Copyright (c) 2016 TapHarmonic, LLC http://tapharmonic.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  This project was written by Bob McCune -- http://bobmccune.com
//

import UIKit

class RainbowView: UIView {

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        // We're going to draw a happy little blue sky gradient right here...
        context.drawBlueSkyGradient(in: rect)

        let colors = [
            UIColor(colorLiteralRed: 1.0,   green: 0.25,  blue: 0.25,  alpha: 1.0), // red
            UIColor(colorLiteralRed: 1.0,   green: 0.708, blue: 0.014, alpha: 1.0), // orange
            UIColor(colorLiteralRed: 1.0,   green: 0.997, blue: 0.369, alpha: 1.0), // yellow
            UIColor(colorLiteralRed: 0.381, green: 1.0,   blue: 0.369, alpha: 1.0), // green
            UIColor(colorLiteralRed: 0.374, green: 0.369, blue: 1.0,   alpha: 1.0), // blue
            UIColor(colorLiteralRed: 0.514, green: 0.283, blue: 0.768, alpha: 1.0), // purple
        ]

        var radius = rect.width * 1.25
        let lineWidth: CGFloat = bounds.width <= 320 ? 26 : 32 // use thinner lines on skinny devices
        let centerPoint = CGPoint(x: rect.midX, y: rect.maxY)

        for color in colors {
            let colorPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)

            // "Erase" the inner portion of the outer arc by relying on the non-zero winding rule
            let erasurePath = UIBezierPath(arcCenter: centerPoint, radius: radius - lineWidth - 1.0, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
            colorPath.append(erasurePath)

            color.setFill()
            colorPath.fill()
            radius -= lineWidth
        }
    }
}
