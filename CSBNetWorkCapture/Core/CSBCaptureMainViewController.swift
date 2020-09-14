//
//  CSBCaptureMainViewController.swift
//  CSBNetWorkCapture
//
//  Created by seibin on 2020/09/07.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit

class CSBCaptureMainViewController: UIViewController {
    @IBOutlet weak var containerHeaderView: UIView!
    @IBOutlet weak var containerViewTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        containerHeaderView.backgroundColor = UIColor.hex(string: "1BA9FF", alpha: 1)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(CSBCaptureMainViewController.didSwipeOnView(_:)))
        containerHeaderView.addGestureRecognizer(panGesture)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func didSwipeOnView(_ gestureRecognizer: UIPanGestureRecognizer) {
        let moveY = gestureRecognizer.translation(in:self.view).y
        if case .Down = gestureRecognizer.verticalDirection(target: containerHeaderView) {
            if containerViewTop.constant >= UIScreen.main.bounds.height - 50.0 {
                return
            }
        } else {
            if containerViewTop.constant <= 50.0 {
                return
            }
        }
        
        containerViewTop.constant +=  moveY
        gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
}
