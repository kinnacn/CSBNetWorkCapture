//
//  ViewController.swift
//  demo
//
//  Created by seibin on 2020/09/09.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit
//import CSBNetWorkCapture

class ViewController: UIViewController {
    
    private let syncQueue = DispatchQueue(label: "TwstViewController")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Get Json
    @IBAction func buttonClick(_ sender: Any) {
        syncQueue.async {
            if let url = URL(string: "https://httpbin.org/json") {
                let request = URLRequest(url: url)
                self.loadUrl(request)
            }
        }
    }
    
    @IBAction func jsonPostButtonClick(_ sender: Any) {
        syncQueue.async {
            let urlString = "https://httpbin.org/post"
            let request = NSMutableURLRequest(url: URL(string: urlString)!)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let params:[String:Any] = [
                "freeform": "ios"
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                self.loadUrl(request as URLRequest)
            } catch {
            }
        }
        
    }
    
    
    @IBAction func getXmlButtonAction(_ sender: Any) {
        syncQueue.async {
            if let url = URL(string: "https://httpbin.org/xml") {
                let request = URLRequest(url: url)
                self.loadUrl(request)
            }
        }
    }
    
    @IBAction func jpgeButtonAction(_ sender: Any) {
        syncQueue.async {
            if let url = URL(string: "https://httpbin.org/image/jpeg") {
                let request = URLRequest(url: url)
                self.loadUrl(request)
            }
        }
    }
    
    
    @IBAction func pngButtonAction(_ sender: Any) {
        syncQueue.async {
            if let url = URL(string: "https://httpbin.org/image/png") {
                let request = URLRequest(url: url)
                self.loadUrl(request)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func loadUrl (_ request: URLRequest) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let sessionTask = session.dataTask(with: request) { (data, response, error) in
            session.invalidateAndCancel()
            
            if let _ = error {
                return
            }
            
            guard let _ = data, let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200 {
                print("succes:\(response.statusCode)")
            } else {
                print("fial:\(response.statusCode)")
            }
        }
        
        sessionTask.resume()
    }
}

