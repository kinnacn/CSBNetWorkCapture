//
//  CSBCaptureDetailResponseViewController.swift
//  CSBNetWorkCapture
//
//  Created by seibin on 2020/09/13.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit
import Foundation

class CSBCaptureDetailResponseViewController: CSBCaptureDetailBaseViewController {
    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var responseImagContentView: UIView!
    @IBOutlet weak var responseImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        responseImagContentView.isHidden = true
        responseImagContentView.backgroundColor = UIColor.csbBackground
        responseTextView.backgroundColor = UIColor.csbBackground
        
        if let contentsType = cbsHttpModel?.responseType, (contentsType == CSBHttpContentType.png.rawValue || contentsType == CSBHttpContentType.jpge.rawValue)  {
            responseImagContentView.isHidden = false
            
            responseTextView.text = createResponeseHeaders(cbsHttpModel)
            responseImageView.image = createResponeseBodyImage(cbsHttpModel)
        } else {
            responseTextView.text = createResponeseHeaders(cbsHttpModel) + createResponeseBodyString(cbsHttpModel)
        }
        view.layoutIfNeeded()
        responseTextView.setContentOffset(CGPoint(x: 0, y: -responseTextView.contentInset.top),animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createResponeseHeaders(_ cbsHttpModel: CSBHttpModel?) -> String {
        var request = "■ Headers ■\n\n"
        if let model = cbsHttpModel, let headers = model.responseHeaders  , headers.count > 0{
            for (key, val) in headers {
                request += "[\(key)] \n\(val)\n\n"
            }
        } else {
            request += "-\n\n"
        }
        
        return request
    }
    
    private func createResponeseBodyString(_ cbsHttpModel: CSBHttpModel?) -> String {
        var request = "■ Body ■\n\n"
        
        guard let model = cbsHttpModel, let bodyLength = model.responseBodyLength, bodyLength > 0, let data = model.responseBodyData, let contentsType = model.responseType else {
            request += "-\n\n"
            return request
        }
        
        if contentsType == CSBHttpContentType.json.rawValue  {
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                let prettyPrintedData = try JSONSerialization.data(withJSONObject: dict!, options: .prettyPrinted)
                
                let format = String(data: prettyPrintedData, encoding: String.Encoding.utf8) ?? "-"
                request += "\(format)\n"
            } catch {
                request += "-\n\n"
            }
            
        } else if contentsType == CSBHttpContentType.xml.rawValue {
            if let xmlString = String(data: data, encoding: .utf8) {
                request += "\(xmlString)\n"
            } else {
                 request += "-\n\n"
            }
        }
        
        return request
    }
    
    private func createResponeseBodyImage(_ cbsHttpModel: CSBHttpModel?) -> UIImage? {
        guard let model = cbsHttpModel, let bodyLength = model.responseBodyLength, bodyLength > 0, let data = model.responseBodyData, let contentsType = model.responseType else {
            return nil
        }
        
        if contentsType == CSBHttpContentType.png.rawValue || contentsType == CSBHttpContentType.jpge.rawValue {
            return UIImage(data: data)
        }
        
        return nil
    }
}
