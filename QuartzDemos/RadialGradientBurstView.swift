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

class RadialGradientBurstView: BaseView {

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        let locations: [CGFloat] = [0, 1]

        let lightPurple = UIColor(displayP3Red: 0.897, green: 0.822, blue: 0.933, alpha: 1)
        let darkPurple = UIColor(displayP3Red: 0.286, green: 0.026, blue: 0.622, alpha: 1)
        let colors = [lightPurple.cgColor, darkPurple.cgColor]

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) else { return }

        let x = rect.midX
        let y = rect.maxY / 4
        let startPoint = CGPoint(x: x, y: y)
        let endPoint = CGPoint(x: x, y: y * 2)

        let startRadius: CGFloat = 1
        let endRadius = rect.width

        let options: CGGradientDrawingOptions = [.drawsAfterEndLocation, .drawsBeforeStartLocation]
        context.drawRadialGradient(gradient, startCenter: startPoint, startRadius: startRadius, endCenter: endPoint, endRadius: endRadius, options: options)
    }

}
