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

class HeartView: UIView {

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setFillColor(#colorLiteral(red: 1, green: 0.7224241537, blue: 0.8232492769, alpha: 1).cgColor)
        context.fill(rect)

        let navigationBarHeight: CGFloat = 64.0 // 44.0 + 20

        context.translateBy(x: rect.midX, y: (bounds.midY + navigationBarHeight) / 4.0)

        // Scale using CGContext extension
        let heartWidth: CGFloat = 185
        context.scale(width: heartWidth, to: 0.65, of: bounds)

        let fillColor = UIColor.red
        let strokeColor = UIColor(colorLiteralRed: 0.8, green: 0, blue: 0, alpha: 1)

        context.setLineWidth(3.0)
        context.setLineJoin(.round)
        context.setStrokeColor(strokeColor.cgColor)
        context.setFillColor(fillColor.cgColor)

        // Start and End points
        let startPoint = CGPoint(x: 0, y: 115)
        let endPoint = CGPoint(x: 0, y: 300)


        // First control point (top)
        let cp1 = CGPoint(x: 75, y: 15)
        // Second control point (bottom)
        let cp2 = CGPoint(x: 220, y: 130)

        // Begin new path and move to starting point
        context.beginPath();
        context.move(to: CGPoint(x: startPoint.x, y: startPoint.y))

        // Draw Right Side
        context.addCurve(to: endPoint, control1: cp1, control2: cp2)
        // Draw Light Side
        context.addCurve(to: startPoint, control1: CGPoint(x: -cp2.x, y: cp2.y), control2: CGPoint(x: -cp1.x, y: cp1.y))

        // Close and draw path
        context.closePath()
        context.drawPath(using: .fillStroke)
    }

}
