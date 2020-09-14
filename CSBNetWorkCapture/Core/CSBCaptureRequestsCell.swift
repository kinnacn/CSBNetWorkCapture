//
//  CSBCaptureRequestsCell.swift
//  CSBNetWorkCapture
//
//  Created by seibin on 2020/09/07.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit

class CSBCaptureRequestsCell: UITableViewCell {
    @IBOutlet weak var resultInfoContentView: UIView!
    @IBOutlet weak var requestNoLabel: UILabel!
    @IBOutlet weak var requestTimeLabel: UILabel!
    @IBOutlet weak var progressTimeLabel: UILabel!
    @IBOutlet weak var requestUrlLanel: UILabel!
    @IBOutlet weak var requestMethodLabel: UILabel!
    @IBOutlet weak var requestContentTypeLabel: UILabel!
    
    var isSuccess: Bool = false {
        didSet {
            if isSuccess {
                resultInfoContentView.backgroundColor = UIColor.csbGreen
            } else {
                resultInfoContentView.backgroundColor = UIColor.csbRed
            }
        }
    }
    
    var requestNo: String? {
        didSet {
            requestNoLabel.text = requestNo
        }
    }
    
    var requestTime: String? {
        didSet {
            requestTimeLabel.text = requestTime
        }
    }
   
    var progressTime: String? {
        didSet {
            progressTimeLabel.text = progressTime
        }
    }
    
    var requestUrl: String? {
        didSet {
            requestUrlLanel.text = requestUrl
        }
    }
    
    var requestMethod: String? {
        didSet {
            requestMethodLabel.text = requestMethod
        }
    }
    
    var requestContentType: String? {
        didSet {
            requestContentTypeLabel.text = requestContentType
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        isSuccess = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
