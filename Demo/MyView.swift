//
//  MyView.swift
//  DSPopup
//
//  Created by DaiLingchi on 2017/8/22.
//  Copyright © 2017年 DiorStone. All rights reserved.
//

import UIKit
import DSPopup

class MyView: UIView,UIGestureRecognizerDelegate {
    
    
    static func buildView() -> MyView {
        let view = UINib.init(nibName: "MyView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! MyView
        return view
    }
}

extension MyView: Popupable {
    
    func ds_showPopup(inView attachView: UIView, completion: (() -> Void)?) {
        self.frame = attachView.bounds
        self.frame.size.width = 90
        self.autoresizingMask = [ .flexibleHeight]
        attachView.addSubview(self)
        
        
        self.frame.origin.x -= self.frame.width
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)


        UIView.animate(withDuration: 0.15, animations: {
            self.frame.origin.x = 0
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    func ds_hidePopup(inView attachView: UIView, completion: (() -> Void)?) {
        
        UIView.animate(withDuration: 0.15, animations: {
            self.frame.origin.x -= self.frame.width
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            completion?()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
    }
}
