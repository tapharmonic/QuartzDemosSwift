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

class RadialGradientShapesView: BaseView {

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Flood background with white
        context.setFillColor(#colorLiteral(red: 0.9019607902, green: 0.9019607902, blue: 0.9019607902, alpha: 1).cgColor)
        context.fill(rect)

        let locations: [CGFloat] = [0.0, 0.5, 1.0]

        let colors = [
            UIColor.yellow.cgColor,
            UIColor.red.cgColor,
            UIColor.orange.cgColor
        ]

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) else { return }

        // Create dynamic margin to show "hollowed out" effect on all devices
        let margin: CGFloat = rect.width * (rect.width <= 320 ? 0.10 : 0.15)
        let startRadius: CGFloat = 75
        let endRadius: CGFloat = 100

        let startPoint = CGPoint(x: rect.minX + startRadius + margin, y: 150)
        let endPoint = CGPoint(x: rect.maxX - endRadius - margin, y: 250)

        context.drawRadialGradient(gradient, startCenter: startPoint, startRadius: startRadius, endCenter: endPoint, endRadius: endRadius, options: [])

    }

}
