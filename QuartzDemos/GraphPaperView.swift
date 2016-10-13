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

class GraphPaperView: UIView {

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Background Color
        let bgColor = UIColor(red: 0.996, green: 0.969, blue: 0.811, alpha: 1.0)
        context.setFillColor(bgColor.cgColor)
        context.fill(rect)

        // Line Color
        let lineColor = UIColor(red: 0.584, green: 0.547, blue: 0.411, alpha: 1.0)
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(1.0)

        // Draw Horizontal Lines
        let gridSize: CGFloat = 20.0
        var linePosition: CGFloat = 0.0
        while linePosition < rect.size.height {
            context.beginPath()
            context.move(to: CGPoint(x: 0, y: linePosition))
            context.addLine(to: CGPoint(x: rect.width, y: linePosition))
            context.strokePath()
            linePosition += gridSize
        }

        // Draw Vertical Lines
        linePosition = CGFloat(0.0)
        while linePosition < rect.size.width {
            context.beginPath()
            context.move(to: CGPoint(x: linePosition, y: 0))
            context.addLine(to: CGPoint(x: linePosition, y: rect.height))
            context.strokePath()
            linePosition += gridSize
        }


        // Set line width for shapes
        context.setLineWidth(3.0)

        // Draw Blue Square
        context.setStrokeColor(UIColor.blue.cgColor)
        context.beginPath()
        context.move(to: CGPoint(x: gridSize * 2, y: gridSize * 6))
        context.addLine(to: CGPoint(x: gridSize * 8, y: gridSize * 6))
        context.addLine(to: CGPoint(x: gridSize * 8, y: gridSize * 12))
        context.addLine(to: CGPoint(x: gridSize * 2, y: gridSize * 12))
        context.closePath()
        context.strokePath()

        // Draw Red Triangle
        context.setStrokeColor(UIColor.red.cgColor)

        let points = [CGPoint(x: gridSize * 9, y: gridSize * 16),
                      CGPoint(x: gridSize * 5, y: gridSize * 22),
                      CGPoint(x: gridSize * 13, y: gridSize * 22)]

        context.beginPath()
        context.addLines(between: points)
        context.closePath()
        context.strokePath()
    }

}
