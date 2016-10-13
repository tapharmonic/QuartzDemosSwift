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

class AppleMaskView: UIView {

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setFillColor(UIColor(patternImage: #imageLiteral(resourceName: "denim")).cgColor)
        context.fill(rect)

        // Mask image created by toMask() extension I added to CGImage
        guard let maskImage = UIImage(named: "apple_mask")?.cgImage?.toMask() else { return }
        guard let colorsImage = UIImage(named: "apple_colors")?.cgImage else { return }

        // This mapping seems wonky in seed 1. It seems like the relationship should be the other
        // way around or the masking method should be called maskedBy or something. Need to file a radar.
        if let masked = colorsImage.masking(maskImage) {
            // Draw shadow to offset from background
            context.setShadow(offset: CGSize(width: 1, height: 1), blur: 12, color: #colorLiteral(red: 0.200000003, green: 0.200000003, blue: 0.200000003, alpha: 1).cgColor)
            let maskedImage = UIImage(cgImage: masked)
            maskedImage.draw(in: drawingRect(for: maskedImage))
        }
    }

    func drawingRect(for image: UIImage) -> CGRect {
        let scale = UIScreen.main.scale
        let size = CGSize(width: image.size.width / scale, height: image.size.height / scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0
        return CGRect(origin: CGPoint(x: x, y: y), size: size)
    }
}
