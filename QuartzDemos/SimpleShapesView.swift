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

class SimpleShapesView: UIView {

    var strokeWidth: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        // Get handle to current CGContext
        guard let context = UIGraphicsGetCurrentContext() else { return }

        // draw gradient background
        context.drawWhiteGradient(in: rect)

        // Set stroke width and color
        context.setLineWidth(strokeWidth)
        context.setStrokeColor(UIColor(white: 0.2, alpha: 1.0).cgColor)

        // Draw red square
        let squareRect = CGRect(x: 30, y: 50, width: 100, height: 100)
        context.setFillColor(UIColor.red.cgColor)
        context.fill(squareRect)
        context.stroke(squareRect)

        // Draw blue circle
        let circleRect = CGRect(x: 180.0, y: 50.0, width: 100.0, height: 100.0)
        context.setFillColor(UIColor.blue.cgColor)
        context.fillEllipse(in: circleRect)
        context.strokeEllipse(in: circleRect)

        // Draw green triangle
        context.setFillColor(UIColor.green.cgColor)
        context.beginPath()
        context.move(to: CGPoint(x: 80, y: 200))
        context.addLine(to: CGPoint(x: 20, y: 300))
        context.addLine(to: CGPoint(x: 140, y: 300))
        context.closePath()
        context.drawPath(using: .fillStroke)

        // Draw orange diamond
        context.setFillColor(UIColor.orange.cgColor)
        context.beginPath()
        context.move(to: CGPoint(x: 230, y: 200))
        context.addLine(to: CGPoint(x: 190, y: 250))
        context.addLine(to: CGPoint(x: 230, y: 300))
        context.addLine(to: CGPoint(x: 270, y: 250))
        context.closePath()
        context.drawPath(using: .fillStroke)
    }

}
