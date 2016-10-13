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

class AbstractGradientViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var scrollViewBuilt = false

    // Overridden by subclases

    func viewClasses() -> [UIView.Type] {
        return [UIView.Type]()
    }

    init() {
        super.init(nibName: "AbstractGradientView", bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !scrollViewBuilt {
            let classes = viewClasses()
            var viewRect = scrollView.frame
            scrollView.contentSize =  CGSize(width: viewRect.width * CGFloat(classes.count), height: viewRect.height)
            for clazz in classes {
                let gradientView = clazz.init(frame: viewRect)
                gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                scrollView.addSubview(gradientView)
                viewRect = viewRect.offsetBy(dx: viewRect.width, dy: 0)
            }
            scrollViewBuilt = true
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        pageControl.currentPage = page
    }

    @IBAction func changePage(_ sender: AnyObject) {
        let scrollViewSize = scrollView.frame.size
        let x = scrollViewSize.width * CGFloat(pageControl.currentPage)
        let y = CGFloat(0)
        let visibleRect = CGRect(origin: CGPoint(x: x, y: y), size: scrollViewSize)
        scrollView.scrollRectToVisible(visibleRect, animated: true)
    }
}
