//
//  CSBCaptureDetailInfoControllerViewController.swift
//  CSBNetWorkCapture
//
//  Created by seibin on 2020/09/13.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit

class CSBCaptureDetailInfoViewController: CSBCaptureDetailBaseViewController {
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoTextView.backgroundColor = UIColor.csbBackground
        infoTextView.text = createInfo(cbsHttpModel)
        view.layoutIfNeeded()
        infoTextView.setContentOffset(CGPoint(x: 0, y: -infoTextView.contentInset.top),animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func createInfo(_ cbsHttpModel: CSBHttpModel?) -> String {
        if let model = cbsHttpModel {
            var info = ""
            info = "[URL]" + "\n"
            info += (model.requestURL ?? "-") + "\n\n"
            
            info += "[Method]" + "\n"
            info += (model.requestMethod ?? "-") + "\n\n"
            
            info += "[Status]" + "\n"
            if let responseStatus = model.responseStatus {
                info +=  String(responseStatus) + "\n\n"
            } else {
                info += "-" + "\n\n"
            }
            
            info += "[Request Date]" + "\n"
            if let requestDate = model.requestDate {
                info += requestDate.debugDescription + "\n\n"
            } else {
                info += "-" + "\n\n"
            }
            
            info += "[Response Date]" + "\n"
            if let responseDate = model.responseDate {
                info += responseDate.debugDescription + "\n\n"
            } else {
                info += "-" + "\n\n"
            }
            
            info += "[Progress TimeInterval]" + "\n"
            if let progressTimeInterval = model.progressTimeInterval {
                info += String(progressTimeInterval) + "\n\n"
            } else {
                info += "-" + "\n\n"
            }
            
            info += "[Timeout]" + "\n"
            info += (model.requestTimeout ?? "-") + "\n\n"
            
            info += "[CachePolicy]" + "\n"
            info += (model.requestCachePolicy ?? "-") + "\n\n"
            
            return info
        }
        
        return "-"
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
