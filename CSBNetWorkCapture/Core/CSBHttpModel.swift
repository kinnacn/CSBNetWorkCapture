//
//  CBSHttpModel.swift
//  CSBNetWorkCapture
//
//  Created by seibin on 2020/09/07.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit

enum CSBHttpContentType: String {
    case json = "application/json"
    case xml = "application/xml"
    case html = "text/html"
    case jpge = "image/jpeg"
    case png = "image/png"
}

class CSBHttpModelManager: NSObject {
    static let shared = CSBHttpModelManager()
    private var models = [CSBHttpModel]()
    private let syncQueue = DispatchQueue(label: "CSBSyncQueue")
    
    func add(_ obj: CSBHttpModel) {
        syncQueue.async {
            self.models.insert(obj, at: 0)
            NotificationCenter.default.post(name: NSNotification.Name.CBSAddHttpModel, object: nil)
        }
    }
    
    func clear() {
        syncQueue.async {
            self.models.removeAll()
            NotificationCenter.default.post(name: NSNotification.Name.CBSClearHttpModels, object: nil)
        }
    }
    
    func getModels() -> [CSBHttpModel] {
        return models
    }
}

class CSBHttpModel: NSObject {
    var requestURL: String?
    var requestURLComponents: URLComponents?
    var requestURLQueryItems: [URLQueryItem]?
    var requestMethod: String?
    var requestCachePolicy: String?
    var requestDate: Date?
    var requestTime: String?
    var requestTimeout: String?
    var requestHeaders: [AnyHashable: Any]?
    var requestType: String?
    var requestBodyLength: Int?
    var requestBodyData: Data?
    
    var responseStatus: Int?
    var responseType: String?
    var responseDate: Date?
    var responseTime: String?
    var responseHeaders: [AnyHashable: Any]?
    var responseBodyLength: Int?
    var responseBodyData: Data?
    
    var progressTimeInterval: Float?
    
    func setRequestInfo(_ request: URLRequest)
    {
        self.requestDate = Date()
        self.requestTime = getTimeFromDate(self.requestDate!)
        self.requestURL = request.url?.absoluteString
        if let requestUrl = request.url?.absoluteString {
            self.requestURLComponents = URLComponents(string: requestUrl)
        }
        self.requestURLQueryItems = self.requestURLComponents?.queryItems
        self.requestMethod = request.httpMethod
        self.requestCachePolicy = request.getCachePolicy()
        self.requestTimeout = String(Double(request.timeoutInterval))
        self.requestHeaders = request.allHTTPHeaderFields
        self.requestType = requestHeaders?["Content-Type"] as! String?
        
        self.requestBodyLength = request.httpBodyStream?.readfullyData().count
        self.requestBodyData = request.httpBodyStream?.readfullyData()
    }
    
    func setResponseInfo(_ response: URLResponse, data: Data, error: Error?)
    {
        self.responseDate = Date()
        self.responseTime = getTimeFromDate(self.responseDate!)
        self.responseStatus = (response as? HTTPURLResponse)?.statusCode
        self.responseHeaders = (response as? HTTPURLResponse)?.allHeaderFields
        if let headers = self.responseHeaders, let contentType = headers["Content-Type"] as? String {
            self.responseType = contentType.components(separatedBy: ";")[0]
        }
        self.responseBodyLength = data.count
        self.responseBodyData = data
        
        self.progressTimeInterval = Float(self.responseDate!.timeIntervalSince(self.requestDate!))
    }
    
    private func getTimeFromDate(_ date: Date) -> String?
    {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.hour, .minute], from: date)
        guard let hour = components.hour, let minutes = components.minute else {
            return nil
        }
        if minutes < 10 {
            return "\(hour):0\(minutes)"
        } else {
            return "\(hour):\(minutes)"
        }
    }
}
