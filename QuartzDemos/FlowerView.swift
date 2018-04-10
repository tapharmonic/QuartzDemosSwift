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

class FlowerView: BaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Reuse the good-ol blue sky gradient
        context.drawBlueSkyGradient(in: rect)

        // Setup colors

        let stemColor = UIColor(displayP3Red: 0.017, green: 0.393, blue: 0.033, alpha: 1.0)
        let discFillColor = UIColor(displayP3Red: 0.996, green: 0.781, blue: 0.0, alpha: 1.0)
        let discStrokeColor = UIColor(displayP3Red: 0.833, green: 0.653, blue: 0.0, alpha: 1.0)
        let petalFillColor = UIColor.white
        let petalStrokeColor = UIColor(displayP3Red: 0.577, green: 0.577, blue: 0.577, alpha: 1.0)


        // Set line styles for strokes
        context.setLineCap(.round)
        context.setLineJoin(.round)

        let radius: CGFloat = 50
        let circleRadians = CGFloat.pi * 2
        let centerX = rect.width / 2.0
        let centerY = rect.height / 2.0

        // Translate origin to center
        context.translateBy(x: centerX, y: centerY - 50);

        // Draw Stem
        context.setStrokeColor(stemColor.cgColor)
        context.setLineWidth(30)
        context.move(to: CGPoint(x: 0, y: 40))
        
        let stemEndPoint = CGPoint(x: 0, y: (rect.height / 2) + 50)
        let cp1 = CGPoint(x: -50, y: 125)
        let cp2 = CGPoint(x: 50, y: 125)
        context.addCurve(to: stemEndPoint, control1: cp1, control2: cp2)

        context.strokePath()


        // Set stroke and fill colors for disc
        context.setLineWidth(5);
        context.setFillColor(discFillColor.cgColor)
        context.setStrokeColor(discStrokeColor.cgColor)

        // Draw yellow disc
        context.beginPath()
        context.addArc(center: .zero, radius: radius, startAngle: 0, endAngle: circleRadians, clockwise: true)
        context.drawPath(using: .fillStroke)


        // Create reusable path
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 55))
        path.addQuadCurve(to: CGPoint(x: 0, y: 155), control: CGPoint(x: -50, y: 155))
        path.addQuadCurve(to: CGPoint(x: 0, y: 55),  control: CGPoint(x: 50, y: 155))

        // Set smaller line width and set fill/stroke colors
        context.setLineWidth(2)
        context.setFillColor(petalFillColor.cgColor)
        context.setStrokeColor(petalStrokeColor.cgColor)

        let numberOfPetals = 13
        let rotationAngle = circleRadians / CGFloat(numberOfPetals)
        
        // Draw Petals
        for _ in 0..<numberOfPetals {
            context.rotate(by: rotationAngle)
            context.addPath(path)
            context.drawPath(using: .fillStroke)
        }
    }
}
