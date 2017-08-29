//
//  PopupWindow.swift

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

import UIKit
import Foundation
import ObjectiveC

fileprivate let PopupableViewIsAdd = UnsafeRawPointer.init(bitPattern: "PopupableViewIsAdd".hashValue)

extension Popupable {
    
    fileprivate var isAdd: Bool {
        set {
            objc_setAssociatedObject(self, PopupableViewIsAdd, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            var returnValue = false
            if let value = objc_getAssociatedObject(self, PopupableViewIsAdd) {
                returnValue = value as! Bool
            }
            return returnValue
        }
    }
}

open class PopupWindow: UIWindow,UIGestureRecognizerDelegate {
    
    /// default is NO. When YES, popup view will be hidden when user touch the translucent background.
    public var tochToHide: Bool = false
    
    // MARK: private
    public var attchView: UIView {
        return self.rootViewController!.view
    }
    var poppuped: Bool = false
    var popupViews: [Popupable] = []

    // MARK: public
    open static let `default`: PopupWindow = {
        let window = PopupWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        return window
    }()
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func showPopupView(_ popupView: Popupable, completion: (() -> Void)? = nil) {
        
        if !popupView.isAdd {
            popupView.isAdd = true
            popupViews.append(popupView)
        }
        //no popup
        if !poppuped {
            poppuped = true
            // show
            
            let attachView: UIView = popupView.ds_attachedView ?? self.attchView
            if attachView == self.attchView {
                self.isHidden = false
                self.makeKeyAndVisible()
            }
            popupView.ds_showPopup(inView: attachView, completion: completion)
        }
    }
    
    internal func hiddenPopupView(_ popupView: Popupable, completion: (() -> Void)? = nil) {
        
        let attachView: UIView = popupView.ds_attachedView ?? self.attchView
        popupView.ds_hidePopup(inView: attachView) { [unowned self] in
            self.poppuped = false
            if attachView == self.attchView {
                self.isHidden = true
                UIApplication.shared.delegate?.window??.makeKeyAndVisible()
            }
            completion?()
            if self.popupViews.count > 0 {
                self.popupViews.removeFirst()
                if let popupView = self.popupViews.first {
                    self.showPopupView(popupView, completion: nil)
                }
            }
        }
    }
    
    // MARK: private
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
        self.windowLevel = UIWindowLevelNormal
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        gesture.delegate = self
        self.addGestureRecognizer(gesture)
    }
    
    func actionTap() {
        if let view = popupViews.first {
            self.hiddenPopupView(view)
        }
    }
    
    // MARK: UIGestureRecognizerDelegate
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return self.tochToHide
    }
}
