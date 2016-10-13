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

class SwiftView: BaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.drawColoredLinearGradient(in: rect, from: #colorLiteral(red: 1, green: 0.6117647059, blue: 0.1215686275, alpha: 1), to: #colorLiteral(red: 1, green: 0.231372549, blue: 0, alpha: 1), direction: .down)

        drawBirdPath(in: context)
    }

    func drawBirdPath(in context: CGContext) {

        // Bird canvas is 100x100
        let birdHW: CGFloat = 100.0

        context.saveGState()

        context.translateBy(x: bounds.midX / 4.0, y: (bounds.midY + navigationBarHeight) / 2.0)

        // Scale using CGContext extension
        context.scale(width: birdHW, to: 0.7, of: bounds)

        // The path coordinates, were created with PaintCode
        context.beginPath()
        context.move(to: CGPoint(x: 1, y: 58.41))
        context.addCurve(to: CGPoint(x: 33.94, y: 85.56), control1: CGPoint(x: 1, y: 58.41),     control2: CGPoint(x: 12.32,  y: 78.06))
        context.addCurve(to: CGPoint(x: 76.41, y: 83.75), control1: CGPoint(x: 55.56, y: 93.06), control2: CGPoint(x: 66.5,   y: 88.41))
        context.addCurve(to: CGPoint(x: 93.65, y: 83.49), control1: CGPoint(x: 86.31, y: 79.1),  control2: CGPoint(x: 91.2,   y: 81.81))
        context.addCurve(to: CGPoint(x: 98.02, y: 89.18), control1: CGPoint(x: 96.09, y: 85.17), control2: CGPoint(x: 97.61,  y: 88.25))
        context.addCurve(to: CGPoint(x: 99.31, y: 89.18), control1: CGPoint(x: 98.44, y: 90.11), control2: CGPoint(x: 99.05,  y: 90.42))
        context.addCurve(to: CGPoint(x: 91.33, y: 63.32), control1: CGPoint(x: 99.57, y: 87.94), control2: CGPoint(x: 103.09, y: 76.42))
        context.addCurve(to: CGPoint(x: 61.74, y: 1),     control1: CGPoint(x: 91.33, y: 63.32), control2: CGPoint(x: 104.37, y: 29.19))
        context.addCurve(to: CGPoint(x: 70.74, y: 48.84), control1: CGPoint(x: 61.74, y: 1),     control2: CGPoint(x: 80.87,  y: 24.88))
        context.addCurve(to: CGPoint(x: 22.36, y: 9.02),  control1: CGPoint(x: 70.74, y: 48.84), control2: CGPoint(x: 56.33,  y: 40.82))
        context.addCurve(to: CGPoint(x: 49.38, y: 43.93), control1: CGPoint(x: 22.36, y: 9.02),  control2: CGPoint(x: 37.03,  y: 31.77))
        context.addCurve(to: CGPoint(x: 11.04, y: 14.71), control1: CGPoint(x: 49.38, y: 43.93), control2: CGPoint(x: 34.97,  y: 35.65))
        context.addCurve(to: CGPoint(x: 57.36, y: 65.13), control1: CGPoint(x: 11.04, y: 14.71), control2: CGPoint(x: 28.28,  y: 43.15))
        context.addCurve(to: CGPoint(x: 1, y: 58.41),     control1: CGPoint(x: 57.63, y: 65.13), control2: CGPoint(x: 33.17,  y: 81.68))

        let birdColor = UIColor.white
        context.setFillColor(birdColor.cgColor)
        context.fillPath()

        context.restoreGState()
    }
}
