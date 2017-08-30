//
//  PopupMenu.swift

//  The MIT License (MIT)
//  Copyright © 2017 DSPopup

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


import Foundation
import UIKit
import DSPopup

open class PopupView: UIView, Popupable {
    
    public var ds_attachedView: UIView?
    public var ds_showAnimation: PopupAnimation?
    public var ds_hideAnimation: PopupAnimation?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func ds_show(anchorView: UIView) {
        
        self.ds_showAnimation = { view, completion in
            
            let frame = anchorView.superview!.convert(anchorView.frame, to: view)
            self.frame.origin.x = frame.minX
            self.frame.origin.y = frame.maxY
            self.frame.size = CGSize(width: frame.width, height: 100)
            
//            self.frame = view.bounds
            self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(self)
            
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            UIView.animate(
                withDuration: 0.15,
                animations: {
                self.transform = CGAffineTransform.identity
                self.alpha = 1
            },
                completion: { finished in
                    completion?()
            })

        }
        self.ds_show()
    }
}
