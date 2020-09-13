//
//  CBSNotTouchedWindow.swift
//  CSBNetWorkCapture
//
//  Created by seibin on 2020/09/12.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit

class CBSNotTouchedWindow: UIWindow {
    //自分自身はサワレナイ
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        
        if view == self {
            return nil
        }
        return view
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
