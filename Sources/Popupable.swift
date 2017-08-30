//
//  Popupable.swift
//
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

public typealias PopupAnimation = (UIView,(() -> Void)?) -> Void

public protocol Popupable: class {
    
    /// default is PopupWindow. You can attach PopupView to any UIView.
    var ds_attachedView: UIView? { get }
    
    /// config show or hide
    var ds_showAnimation: PopupAnimation? { get }
    var ds_hideAnimation: PopupAnimation? { get }
    
    func ds_showPopup(inView attachView: UIView, completion: (() -> Void)?)
    func ds_hidePopup(inView attachView: UIView, completion: (() -> Void)?)
}

/// default
extension Popupable {
    
    public var ds_attachedView: UIView? {
        return PopupWindow.default.attchView
    }
    
    public var ds_showAnimation: PopupAnimation? {
        return nil
    }
    
    public var ds_hideAnimation: PopupAnimation? {
        return nil
    }
    
    public func ds_showPopup(inView attachView: UIView, completion: (() -> Void)?) {
        self.ds_showAnimation?(attachView, completion)
    }
    
    public func ds_hidePopup(inView attachView: UIView, completion: (() -> Void)?) {
        self.ds_hideAnimation?(attachView, completion)
    }
}

/// default-UIView
extension Popupable where Self: UIView {
    
    public func ds_showPopup(inView attachView: UIView, completion: (() -> Void)?) {
        
        if let showAnimation = self.ds_showAnimation {
            showAnimation(attachView, completion)
        } else {
            self.frame = attachView.bounds
            self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            attachView.addSubview(self)
            
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            UIView.animate(
                withDuration: 0.15,
                animations: {
                self.transform = CGAffineTransform.identity
                self.alpha = 1
            },
                completion:{ finished in
                    if finished {
                        completion?()
                    }
            })
        }
    }
    
    public func ds_hidePopup(inView attachView: UIView, completion: (() -> Void)?) {
        
        if let hideAnimation = self.ds_hideAnimation {
            hideAnimation(attachView, completion)
        } else {
            UIView.animate(
                withDuration: 0.15,
                animations: {
                self.alpha = 0
            },
                completion: { [unowned self] finished in
                    if finished {
                        self.removeFromSuperview()
                        completion?()
                }
            })
        }
    }
}

/// API
public extension Popupable {
    
    public func ds_show(_ completion: (() -> Void)? = nil) {
        PopupWindow.default.showPopupView(self, completion: completion)
    }
    
    public func ds_hide(_ completion: (() -> Void)? = nil) {
        PopupWindow.default.hiddenPopupView(self, completion: completion)
    }
}
