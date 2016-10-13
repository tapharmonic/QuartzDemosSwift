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

import Foundation
import UIKit

enum DrawingDirection {
    case up
    case down
    case left
    case right
}

extension CGContext {

    func scale(width: CGFloat, to percent: CGFloat, of rect: CGRect) {
        let scaleValue = rect.width / width * percent // 70% of width
        scaleBy(x: scaleValue, y: scaleValue)
    }

    func drawWhiteGradient(in rect: CGRect) {

        let whiteColor = UIColor.white
        let lightGrayColor = UIColor(red: 0.966, green: 0.966, blue: 0.966, alpha: 1.0)

        let colors = [whiteColor.cgColor, lightGrayColor.cgColor]
        let locations: [CGFloat] = [0.0, 1.0]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) {
            let startPoint = CGPoint(x: rect.midX, y: rect.minY)
            let endPoint = CGPoint(x: rect.midX, y: rect.maxY)
            self.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        }
    }

    func drawColoredLinearGradient(in rect: CGRect, from: UIColor, to: UIColor, direction: DrawingDirection) {

        let colors = [from.cgColor, to.cgColor]
        let locations: [CGFloat] = [0.0, 1.0]

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)!

        let startPoint: CGPoint, endPoint: CGPoint
        switch direction {
        case .up:
            startPoint = CGPoint(x: rect.midX, y: rect.maxY)
            endPoint = CGPoint(x: rect.midX, y: rect.minY)
        case .down:
            startPoint = CGPoint(x: rect.midX, y: rect.minY)
            endPoint = CGPoint(x: rect.midX, y: rect.maxY)
        default:
            startPoint = CGPoint.zero
            endPoint = CGPoint.zero
        }
        drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
    }


    func drawBlueSkyGradient(in rect: CGRect) {

        let locations: [CGFloat] = [0.0, 1.0]
        let lightBlueColor = UIColor(colorLiteralRed: 0.942, green: 0.970, blue: 1.0, alpha: 1.0)
        let darkerBlueColor = UIColor(colorLiteralRed: 0.498, green: 0.735, blue: 1.0, alpha: 1.0)

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let colors = [lightBlueColor.cgColor, darkerBlueColor.cgColor]
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) else {
            print("Bailing early from gradient creation: WTF?")
            return
        }

        let point = CGPoint(x: 100, y: 100)
        let startRadius: CGFloat = 100
        let endRadius = rect.height + rect.height * 0.3
        drawRadialGradient(gradient, startCenter: point, startRadius: startRadius, endCenter: point, endRadius: endRadius, options: .drawsBeforeStartLocation)
    }

    func addRoundedPath(in rect: CGRect, radius: CGFloat) {
        saveGState()

        let minX = rect.minX
        let maxX = rect.maxX
        let minY = rect.minY
        let maxY = rect.maxY

        move(to: CGPoint(x: minX + radius, y: minY))

        // CGContextAddArc is not aware of flipped context, so 0 results in clockwise direction
        let clockwise = false

        let pi = CGFloat.pi
        let pi_2 = pi / 2
        
        
        addArc(center: CGPoint(x: maxX - radius, y: minY + radius), radius: radius, startAngle: pi_2 * 3, endAngle: 0, clockwise: clockwise)
        addArc(center: CGPoint(x: maxX - radius, y: maxY - radius), radius: radius, startAngle: 0, endAngle: pi_2, clockwise: clockwise)
        addArc(center: CGPoint(x: minX + radius, y: maxY - radius), radius: radius, startAngle: pi_2, endAngle: pi, clockwise: clockwise)
        addArc(center: CGPoint(x: minX + radius, y: minY + radius), radius: radius, startAngle: pi, endAngle: pi_2 * 3, clockwise: clockwise)

        closePath()

        restoreGState()
    }

}
