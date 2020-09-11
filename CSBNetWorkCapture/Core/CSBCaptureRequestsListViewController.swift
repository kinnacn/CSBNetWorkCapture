//
//  CSBCaptureRequestsListViewController.swift
//  CSBNetWorkCapture
//
//  Created by seibin on 2020/09/07.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit

class CSBCaptureRequestsListViewController: UIViewController {
    @IBOutlet weak var RequestsListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        return 10//repositorieDicInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //        let repositorieDicInfo = repositorieDicInfos[indexPath.row]
        //        cell.textLabel?.text = repositorieDicInfo[Constans.RepositoriyKeyName.fullName] as? String ?? ""
        //        cell.detailTextLabel?.text = repositorieDicInfo[Constans.RepositoriyKeyName.language] as? String ?? ""
        //        cell.tag = indexPath.row
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        didSelectIndex = indexPath.row
        //        performSegue(withIdentifier: Constans.Identifier.repository, sender: self)
    }
}
