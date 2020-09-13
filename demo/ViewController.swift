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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        getRepositoryInfos("swift")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func getRepositoryInfos(_ keyWord: String) {
        guard let url = URL(string: "\("https://api.github.com/search/repositories?q=")\(keyWord)") else {
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let request = URLRequest(url: url)
        
        let sessionTask = session.dataTask(with: request) { (data, response, error) in
            session.invalidateAndCancel()
            
            if let _ = error {
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200 {
                guard  let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []), let responseDic = responseJSON as? [String: Any] else {
                    return
                }
                
                guard let items = responseDic["items"] as? [[String: Any]] else {
                    return
                }
//                print(items)
                
            } else {
            }
        }
        
        sessionTask.resume()
    }

}

