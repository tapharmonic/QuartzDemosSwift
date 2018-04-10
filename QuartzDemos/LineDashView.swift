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

class LineDashView: BaseView {

    let margin: CGFloat = 20.0

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Set initial translation
        context.translateBy(x: 0, y: navigationBarHeight + 60)

        context.setFillColor(UIColor.black.cgColor)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(10)

        // Dash pattern
        let pattern: [CGFloat] = [10, 5, 20, 5]

        // Solid Black Line - No Dash
        drawLine(in: context, title: "Line 1:", description: "No Pattern")

        // 10-on, 5-off
        context.setLineDash(phase: 0, lengths: pattern)
        drawLine(in: context, title: "Line 2:", description: "10-on, 5-off")

        // 10-on, 5-off, 20-on, 5-off
        context.setLineDash(phase: 0, lengths: pattern)
        drawLine(in: context, title: "Line 3:", description: "10-on, 5-off, 20-on, 5-off")

        // 20-on, 5-off, 10-on, 5-off
        context.setLineDash(phase: 15, lengths: pattern)
        drawLine(in: context, title: "Line 4:", description: "20-on, 5-off, 10-on, 5-off")
    }

    func drawLine(in context: CGContext, title: NSString, description: NSString) {
        // Draw Text
        let topMargin: CGFloat = -30
        title.draw(at: CGPoint(x: margin, y: topMargin), withAttributes: [
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)
        ])
        description.draw(at: CGPoint(x: margin + 50, y: topMargin), withAttributes: [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15)
        ])
        // Draw Line
        context.move(to: CGPoint(x: margin, y: 0))
        context.addLine(to: CGPoint(x: bounds.width - margin, y: 0))
        context.strokePath()

        // Translate y-origin
        context.translateBy(x: 0, y: 80)
    }
}
