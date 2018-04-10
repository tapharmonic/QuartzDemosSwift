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

class SmileyView: BaseView {

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Deep yellow color
        let fillColor = UIColor(displayP3Red: 1.0, green: 0.837, blue: 0.0, alpha: 1.0)
        context.setFillColor(fillColor.cgColor)
        context.fill(rect)

        // Use black color for remaining operations
        context.setFillColor(UIColor.black.cgColor)

        var yPos = navigationBarHeight + 100

        // Draw Eyes
        let width: CGFloat = 50.0
        let height: CGFloat = 65.0
        let quarter = rect.width / 4.0
        context.fillEllipse(in: CGRect(x: quarter, y: yPos, width: width, height: height));
        context.fillEllipse(in: CGRect(x: quarter * 3 - width, y: yPos, width: width, height: height));

        // Define start, end, and control points
        yPos += 100
        let mouthMargin: CGFloat = rect.width / 5
        let startPoint = CGPoint(x: mouthMargin, y: yPos)
        let endPoint = CGPoint(x: rect.width - mouthMargin, y: yPos)
        var cp = CGPoint(x: rect.midX, y: yPos + 50)

        context.beginPath()

        // Add quad curve for top part of mouth
        context.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        context.addQuadCurve(to: endPoint, control: cp)

        // Pull control point y value down.
        // Increasing this value opens his mouth, decreasing it closes it
        cp.y += 100

        // Add quad curve for bottom part of mouth
        context.addQuadCurve(to: startPoint, control: cp)
        context.closePath()

        // Draw smiley mouth
        context.fillPath()
    }

}
