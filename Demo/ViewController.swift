//
//  ViewController.swift
//  Demo
//
//  Created by DaiLingchi on 2017/8/22.
//  Copyright © 2017年 DiorStone. All rights reserved.
//

import UIKit
import DSPopup

class ViewController: UIViewController {

    var menu = PopupView()
    var show: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func show(_ sender: Any) {
        menu.ds_attachedView = self.view
        if show {
            show = false
            menu.ds_hide({
                
            })
        } else {
            show = true
            menu.ds_show({ 
                
            })
        }
    }
    
    @IBAction func showPopupMenu(_ sender: UIButton) {
        PopupWindow.default.tochToHide = true
        let view = MyView.buildView()
        view.ds_show()
    }
}
