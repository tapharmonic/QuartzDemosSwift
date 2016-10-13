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

class FlippedPathsView: BaseView {

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Colors
        let indigoColor    = #colorLiteral(red: 0.1882352941, green: 0.2274509804, blue: 0.6470588235, alpha: 1)
        let lightBlueColor = #colorLiteral(red: 0.07843137255, green: 0.5882352941, blue: 0.9450980392, alpha: 1)
        let blueColor      = #colorLiteral(red: 0.1176470588, green: 0.5019607843, blue: 0.9411764706, alpha: 1)

        context.saveGState()

        // Top left
        drawCornerPath(context: context, rect: rect, color: indigoColor)

        // Top right
        context.translateBy(x: rect.width, y: 0)
        context.scaleBy(x: -1, y: 1)
        drawCornerPath(context: context, rect: rect, color: lightBlueColor)

        // Bottom right
        context.translateBy(x: 0, y: rect.height)
        context.scaleBy(x: 1, y: -1)
        drawCornerPath(context: context, rect: rect, color: indigoColor)

        // Bottom left
        context.translateBy(x: rect.width, y: 0)
        context.scaleBy(x: -1, y: 1)
        drawCornerPath(context: context, rect: rect, color: lightBlueColor)

        context.restoreGState()

        context.saveGState()

        drawInnerPath(context: context, rect: rect, color: blueColor)

        context.translateBy(x: rect.width, y: 0)
        context.scaleBy(x: -1, y: 1)
        drawInnerPath(context: context, rect: rect, color: blueColor)

        context.restoreGState()
    }

    func drawCornerPath(context: CGContext, rect: CGRect, color: UIColor) {
        let path = CGMutablePath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: 30))
        
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: 0))
        path.closeSubpath()

        context.addPath(path)
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setFillColor(color.cgColor)
        context.drawPath(using: .fillStroke)
    }

    func drawInnerPath(context: CGContext, rect: CGRect, color: UIColor) {
        context.beginPath()
        context.move(to: CGPoint(x: 0, y: 30))
        context.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        context.addLine(to: CGPoint(x: 0, y: rect.maxY - 30))
        context.closePath()
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setFillColor(color.cgColor)
        context.drawPath(using: .fillStroke)
    }
}





