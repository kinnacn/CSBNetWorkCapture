//
//  CSBCaptureRequestsListViewController.swift
//  CSBNetWorkCapture
//
//  Created by seibin on 2020/09/07.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit

class CSBCaptureRequestsListViewController: UIViewController {
    @IBOutlet weak var requestsListTableView: UITableView!
    
    private var models = [CBSHttpModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        let nib = UINib(nibName: CSBCaptureRequestsCell.className, bundle: Bundle(for: CSBCaptureRequestsCell.self))
        requestsListTableView.register(nib, forCellReuseIdentifier: CSBCaptureRequestsCell.className)
        requestsListTableView.estimatedRowHeight = 10000
        requestsListTableView.rowHeight = UITableViewAutomaticDimension
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.addModel(notification:)), name: NSNotification.Name.CBSAddHttpModel, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func addModel(notification: NSNotification?) {
        models = CBSHttpModelManager.shared.getModels()
//        print(models)
        DispatchQueue.main.async {
            self.requestsListTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CSBCaptureRequestsListViewController: UITableViewDataSource, UITableViewDelegate {
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CSBCaptureRequestsCell.className) as! CSBCaptureRequestsCell
        let model = models[indexPath.row]
        
        cell.requestNo = String(models.count - indexPath.row)
        cell.requestTime = model.requestTime
        cell.progressTime =  String(format: "%.2f", model.progressTimeInterval ?? 0)
        cell.requestUrl = model.requestURL
        cell.requestMethod = model.requestMethod
        cell.requestContentType = model.requestType
        
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let csbCaptureStoryboard = UIStoryboard(name: "CSBCapture", bundle: Bundle(for: CSBCaptureDetailTabBarController.self))
        let csbCaptureDetailTabBarController = csbCaptureStoryboard.instantiateViewController(withIdentifier: CSBCaptureDetailTabBarController.className) as! CSBCaptureDetailTabBarController
        
        navigationController?.pushViewController(csbCaptureDetailTabBarController, animated: true)
    }
}
