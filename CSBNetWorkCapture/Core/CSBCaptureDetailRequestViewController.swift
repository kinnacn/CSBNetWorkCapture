//
//  CSBCaptureDetailRequestControllerViewController.swift
//  CSBNetWorkCapture
//
//  Created by seibin on 2020/09/13.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit

class CSBCaptureDetailRequestViewController: CSBCaptureDetailBaseViewController {

    @IBOutlet weak var requestTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        requestTextView.backgroundColor = UIColor.csbBackground
        requestTextView.text = createRequestHeaders(cbsHttpModel) + createRequestBody(cbsHttpModel)
        view.layoutIfNeeded()
        requestTextView.setContentOffset(CGPoint(x: 0, y: -requestTextView.contentInset.top),animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createRequestHeaders(_ cbsHttpModel: CSBHttpModel?) -> String {
        var request = "■ Headers ■\n\n"
        if let model = cbsHttpModel, let headers = model.requestHeaders , headers.count > 0{
            for (key, val) in headers {
                request += "[\(key)] \n\(val)\n\n"
            }
        } else {
            request += "-\n\n"
        }
        
        return request
    }

    private func createRequestBody(_ cbsHttpModel: CSBHttpModel?) -> String {
        var request = "■ Body ■\n\n"
        if let model = cbsHttpModel, let bodyLength = model.requestBodyLength, bodyLength > 0, let data = model.requestBodyData {
            let strData = String(data: data, encoding: .utf8) ?? "-"
            request += "\(strData)\n"
        } else {
            request += "-\n\n"
        }
        
        return request
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
