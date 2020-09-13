//
//  CBSHelper.swift
//  CSBNetWorkCapture
//
//  Created by seibin on 2020/09/07.
//  Copyright © 2020年 seibin. All rights reserved.
//

import Foundation

extension URLSessionConfiguration {
    // .defaultをモック用と入れ替えるメソッド
    public class func setupCSBCaptureDefaultSessionConfiguration() {
        let defaultSessionConfiguration = class_getClassMethod(URLSessionConfiguration.self, #selector(getter: URLSessionConfiguration.default))
        let swizzledDefaultSessionConfiguration = class_getClassMethod(URLSessionConfiguration.self, #selector(getter: URLSessionConfiguration.cbsCaptureDefaultSessionConfiguration))
        method_exchangeImplementations(defaultSessionConfiguration!, swizzledDefaultSessionConfiguration!)
    }
    
    public class func releseCSBCaptureDefaultSessionConfiguration() {
        let defaultSessionConfiguration = class_getClassMethod(URLSessionConfiguration.self, #selector(getter: URLSessionConfiguration.default))
        let swizzledDefaultSessionConfiguration = class_getClassMethod(URLSessionConfiguration.self, #selector(getter: URLSessionConfiguration.cbsCaptureDefaultSessionConfiguration))
        method_exchangeImplementations(swizzledDefaultSessionConfiguration!, defaultSessionConfiguration!)
    }
    // .defaultと入れ替えるプロパティ変数
    @objc private dynamic class var cbsCaptureDefaultSessionConfiguration: URLSessionConfiguration {
        let configuration = self.cbsCaptureDefaultSessionConfiguration
        configuration.protocolClasses?.insert(CSBCaptureProtocol.self, at: 0)
//         URLProtocol.registerClass(CSBCaptureProtocol.self)
        return configuration
    }
}

extension NSNotification.Name {
//    static let NFXReloadData = Notification.Name("NFXReloadData")
    static let CBSAddHttpModel = Notification.Name("CBSAddHttpModel")
    static let CBSClearHttpModels = Notification.Name("CBSClearHttpModels")
}

extension UIColor {
    class func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    class func hex ( string : String, alpha : CGFloat) -> UIColor {
        let string_ = string.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: string_ as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            return UIColor.white;
        }
    }
}

extension UIPanGestureRecognizer {
    enum GestureDirection {
        case Up
        case Down
        case Left
        case Right
    }
    
    /// Get current vertical direction
    ///
    /// - Parameter target: view target
    /// - Returns: current direction
    func verticalDirection(target: UIView) -> GestureDirection {
        return self.velocity(in: target).y > 0 ? .Down : .Up
    }
    
    /// Get current horizontal direction
    ///
    /// - Parameter target: view target
    /// - Returns: current direction
    func horizontalDirection(target: UIView) -> GestureDirection {
        return self.velocity(in: target).x > 0 ? .Right : .Left
    }
    
    /// Get a Tuple for current horizontal/vertical direction
    ///
    /// - Parameter target: view target
    /// - Returns: current direction
    func versus(target: UIView) -> (horizontal: GestureDirection, vertical: GestureDirection) {
        return (self.horizontalDirection(target: target), self.verticalDirection(target: target))
    }
    
}

// UIApplication.shared.topViewController
extension UIApplication {
    var topViewController: UIViewController? {
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }
}

extension NSObject {
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}

extension URLRequest
{
    func getCachePolicy() -> String
    {
        switch cachePolicy {
        case .useProtocolCachePolicy: return "UseProtocolCachePolicy"
        case .reloadIgnoringLocalCacheData: return "ReloadIgnoringLocalCacheData"
        case .reloadIgnoringLocalAndRemoteCacheData: return "ReloadIgnoringLocalAndRemoteCacheData"
        case .returnCacheDataElseLoad: return "ReturnCacheDataElseLoad"
        case .returnCacheDataDontLoad: return "ReturnCacheDataDontLoad"
        case .reloadRevalidatingCacheData: return "ReloadRevalidatingCacheData"
        }
    }
}
