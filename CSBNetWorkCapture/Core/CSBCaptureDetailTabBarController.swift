//
//  CSBCaptureDetailTabBarController.swift
//  CSBNetWorkCapture
//
//  Created by seibin on 2020/09/07.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit

class CSBCaptureDetailTabBarController: UITabBarController {
    var cbsHttpModel: CSBHttpModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let childs = viewControllers {
            for child in childs {
                (child as? CSBCaptureDetailBaseViewController)?.cbsHttpModel = cbsHttpModel
                _ = (child as? CSBCaptureDetailBaseViewController)?.view
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ボタン押下時の呼び出しメソッド
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
