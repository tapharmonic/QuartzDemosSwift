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

struct Face {

    private let size: CGSize
    private let image: CGImage

    init(image: CGImage) {
        self.image = image
        size = CGSize(width: image.width, height: image.height)
    }

    func draw(in context: CGContext, at: CGPoint) {
        // Should be using UIScreen.main().scale instead of hardcoding value.
        let scale = UIScreen.main.scale
        let imageRect = CGRect(x: at.x, y: at.y, width: size.width / scale, height: size.height / scale)

        // Draw frame
        drawImageFrame(in: context, imageRect: imageRect)

        // Draw image
        UIImage(cgImage: image).draw(in: imageRect)
    }

    private func drawImageFrame(in context: CGContext, imageRect: CGRect) {
        context.saveGState()
        context.setFillColor(UIColor.white.cgColor)
        context.setStrokeColor(UIColor.darkGray.cgColor)
        context.setShadow(offset: CGSize(width: 2, height: 2), blur: 8.0, color: #colorLiteral(red: 0.4266758859, green: 0.4266631007, blue: 0.4266703427, alpha: 1).cgColor)
        // Round image frame with CGContext extension
        context.addRoundedPath(in: imageRect.insetBy(dx: -10, dy: -10), radius: 4)
        context.drawPath(using: .fill)
        context.restoreGState()
    }
}

class BeatlesView: BaseView {

    let imageWidth: CGFloat = 120.0
    let imageHeight: CGFloat  = 115.0

    // Originally designed for 320x480 screen
    let originalWidth: CGFloat = 320.0

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Draw white gradient background
        context.drawWhiteGradient(in: rect)

        context.translateBy(x: 0, y: self.navigationBarHeight + 40)

        // Scale context so the same layout is preserved across device sizes
        let contextScale = bounds.width / originalWidth
        context.scaleBy(x: contextScale, y: contextScale)

        // Draw logo image
        if let logoImage = UIImage(named: "beatles_logo") {
            let centerX = ((rect.width - logoImage.size.width * contextScale) / 2) / contextScale
            logoImage.draw(at: CGPoint(x: centerX, y: 180))
        }

        let faceRects = [
            makeFaceRect(x: 435, y: 55), // John
            makeFaceRect(x: 225, y: 40), // Paul
            makeFaceRect(x: 60,  y: 60), // George
            makeFaceRect(x: 555, y: 70)  // Ringo
        ]

        let destPoints = [
            CGPoint(x: 20,  y: 30),  // John
            CGPoint(x: 180, y: 30),  // Paul
            CGPoint(x: 20,  y: 270), // George
            CGPoint(x: 180, y: 270)  // Ringo
        ]

        // Must have same number of sources as destinations
        assert(faceRects.count == destPoints.count)

        // Draw faces
        for (i, face) in cropFaces(at: faceRects).enumerated() {
            face.draw(in: context, at: destPoints[i])
        }
    }

    func makeFaceRect(x: CGFloat, y: CGFloat) -> CGRect {
        let scale = UIScreen.main.scale
        return CGRect(x: x * scale, y: y * scale, width: imageWidth * scale, height: imageHeight * scale)
    }

    func cropFaces(at rects: [CGRect]) -> [Face] {
        // Group Photo
        guard let image = UIImage(named: "beatles")?.cgImage else {
            fatalError("Can't find 'beatles' image.")
        }
        var faces = [Face]()
        for rect in rects {
            if let faceImage = image.cropping(to: rect) {
                faces.append(Face(image: faceImage))
            }
        }
        return faces
    }
}
