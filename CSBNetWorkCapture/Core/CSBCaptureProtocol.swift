//
//  CSBCaptureProtocol.swift
//  NetworkDebugging
//
//  Created by seibin on 2020/09/04.
//  Copyright © 2020年 seibin. All rights reserved.
//

import UIKit

class CSBCaptureProtocol: URLProtocol {
    private static let cbsInternalKey = "CSBCaptureProtocolInternalKey"
    private lazy var session: URLSession = { [unowned self] in
        return URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        }()
    
    private let cbsHttpModel = CBSHttpModel()
    private var response: URLResponse?
    private var responseData: NSMutableData?
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return canServeRequest(request)
    }
    
    override open class func canInit(with task: URLSessionTask) -> Bool {
        guard let request = task.currentRequest else { return false }
        return canServeRequest(request)
    }
    
    override open func startLoading() {
        cbsHttpModel.setRequestInfo(request)
        
        let mutableRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        URLProtocol.setProperty(true, forKey: CSBCaptureProtocol.cbsInternalKey, in: mutableRequest)
        
        session.dataTask(with: mutableRequest as URLRequest).resume()
    }
    
    override open func stopLoading() {
        session.getTasksWithCompletionHandler { dataTasks, _, _ in
            dataTasks.forEach { $0.cancel() }
        }
        
        responseData = nil
        response = nil
    }
    
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    private class func canServeRequest(_ request: URLRequest) -> Bool
    {
        guard URLProtocol.property(forKey: CSBCaptureProtocol.cbsInternalKey, in: request) == nil, let url = request.url, (url.absoluteString.hasPrefix("http") || url.absoluteString.hasPrefix("https")) else {
            return false
        }
        
        return true
    }
}

extension CSBCaptureProtocol: URLSessionDataDelegate {
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData?.append(data)
        
        client?.urlProtocol(self, didLoad: data)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.response = response
        self.responseData = NSMutableData()
        
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        completionHandler(.allow)
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        defer {
            if let error = error {
                client?.urlProtocol(self, didFailWithError: error)
            } else {
                client?.urlProtocolDidFinishLoading(self)
            }
        }
        
        if let response = self.response {
            let data = (self.responseData ?? NSMutableData()) as Data
            cbsHttpModel.setResponseInfo(response, data: data, error: error)
        }
        
        CBSHttpModelManager.shared.add(cbsHttpModel)
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        
        let updatedRequest: URLRequest
        if URLProtocol.property(forKey: CSBCaptureProtocol.cbsInternalKey, in: request) != nil {
            let mutableRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
            URLProtocol.removeProperty(forKey: CSBCaptureProtocol.cbsInternalKey, in: mutableRequest)
            
            updatedRequest = mutableRequest as URLRequest
        } else {
            updatedRequest = request
        }
        
        client?.urlProtocol(self, wasRedirectedTo: updatedRequest, redirectResponse: response)
        completionHandler(updatedRequest)
    }
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.previousFailureCount > 0 {
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
        } else if let serverTrust = challenge.protectionSpace.serverTrust {
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
        } else {
            print("unknown state. error: \(challenge.error)")
            // do something w/ completionHandler here
        }
    }
}
