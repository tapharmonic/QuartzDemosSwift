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

class RadialGradientSphereView: BaseView {

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Flood background with white
        context.setFillColor(#colorLiteral(red: 0.8924632238, green: 0.9842924962, blue: 0.8029377187, alpha: 1).cgColor)
        context.fill(rect)

        let midX = rect.midX
        let midY = rect.midY - 20 // weight towards top

        // Draw Shadow Layer
        context.addArc(center: CGPoint(x: midX, y: midY), radius: 120, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        context.setShadow(offset: CGSize(width: 3, height: 1), blur: 10, color: #colorLiteral(red: 0.4254944687, green: 0.5558870475, blue: 0.3368048637, alpha: 1).cgColor)
        context.fillPath()

        // Add a clipping region to smooth edges
        context.addArc(center: CGPoint(x: midX, y: midY), radius: 120, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        context.clip()

        let midPoint = CGPoint(x: midX, y: midY)
        let lightPoint = CGPoint(x: midPoint.x * 0.8, y: midPoint.y * 0.7)

        if let greenGradient = makeGreenGradient() {
            context.drawRadialGradient(greenGradient, startCenter: lightPoint, startRadius: 0, endCenter: midPoint, endRadius: 121, options: [])
        }
    }

    func makeGreenGradient() -> CGGradient? {

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let colors = [
            UIColor(displayP3Red: 0.415, green: 0.806, blue: 0.445, alpha: 1.0).cgColor,
            UIColor(displayP3Red: 0.359, green: 0.687, blue: 0.385, alpha: 1.0).cgColor,
            UIColor(displayP3Red: 0.303, green: 0.588, blue: 0.325, alpha: 1.0).cgColor
        ]

        let locations: [CGFloat] = [0.0, 0.7, 1.0]

        return CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
    }

}
