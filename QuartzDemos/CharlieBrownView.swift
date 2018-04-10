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
import AVFoundation

class CharlieBrownView: BaseView {

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }
        // Fill background with Yellow
        let fillColor = UIColor(displayP3Red: 0.961, green: 0.704, blue: 0.159, alpha: 1.0)
        context.setFillColor(fillColor.cgColor)
        context.fill(rect)

        // Set stroke color and line width
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(60)

        // Translate Y down yPos points
        let lineHeight: CGFloat = 100
        let yPos = (rect.height - navigationBarHeight - lineHeight) / 2.0
        context.translateBy(x: 0, y: yPos)

        let scale = rect.width / 320.0

        let blackLines = [
            CGPoint(x: -30.0 * scale, y: 130.0),
            CGPoint(x: 45.0 * scale,  y: 30.0),
            CGPoint(x: 100.0 * scale, y: 100.0),
            CGPoint(x: 160.0 * scale, y: 30.0),
            CGPoint(x: 220.0 * scale, y: 100.0),
            CGPoint(x: 275.0 * scale, y: 30.0),
            CGPoint(x: 350.0 * scale, y: 130.0)
        ]

        context.addLines(between: blackLines)

        context.strokePath();
    }

}
