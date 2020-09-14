//
//  CSBCapture.swift
//  NetworkDebugging
//
//  Created by seibin on 2020/09/06.
//  Copyright © 2020年 seibin. All rights reserved.
//

import Foundation

open class CSBCapture: NSObject {
    open static let shared = CSBCapture()
    private var rootViewControllerObservationTimer: Timer?
    private var csbCaptureMainViewController: CSBCaptureMainViewController?
    private var csbCaptureWindow: CSBNotTouchedWindow?
    
    private override init() {}
    
    open func startCpature() {
        registerCSBCaptureProtocol()
        URLSessionConfiguration.setupCSBCaptureDefaultSessionConfiguration()
        startRootViewControllerObservation()
    }
    
    open func stopCpature() {
        unregisterCSBCaptureProtocol()
        URLSessionConfiguration.releseCSBCaptureDefaultSessionConfiguration()
        stopRootViewControllerObservation()
        hiddenCaptureWindow()
    }
}

// MARK: - CSBCaptureProtocol
extension CSBCapture {
    private func registerCSBCaptureProtocol() {
        URLProtocol.registerClass(CSBCaptureProtocol.self)
    }
    
    private func unregisterCSBCaptureProtocol() {
        URLProtocol.unregisterClass(CSBCaptureProtocol.self)
    }
    
}

// MARK: - ViewController
extension CSBCapture {
    private func startRootViewControllerObservation() {
        rootViewControllerObservationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CSBCapture.timerUpdate), userInfo: nil, repeats: true)
    }
    
    private func stopRootViewControllerObservation() {
        rootViewControllerObservationTimer?.invalidate()
        rootViewControllerObservationTimer = nil
    }
    
    @objc private func timerUpdate() {
        guard let _ = UIApplication.shared.topViewController else {
            return
        }
        
        stopRootViewControllerObservation()
        showCaptureWindow()
    }
    
    private func crateMainViewController() -> CSBCaptureMainViewController {
        let csbCaptureStoryboard = UIStoryboard(name: "CSBCapture", bundle: Bundle(for: CSBCaptureMainViewController.self))
        let mainViewController = csbCaptureStoryboard.instantiateViewController(withIdentifier: CSBCaptureMainViewController.className) as! CSBCaptureMainViewController
        
        return mainViewController
        
    }
    
    private func showCaptureWindow () {
        if csbCaptureWindow != nil {
            csbCaptureWindow?.isHidden = true
        } else {
            let newWindow = CSBNotTouchedWindow(frame: UIScreen.main.bounds)
            let mainViewController = crateMainViewController()
            newWindow.rootViewController = mainViewController
            newWindow.makeKeyAndVisible()
            csbCaptureWindow = newWindow
        }
    }
    
    private func hiddenCaptureWindow() {
        csbCaptureWindow?.isHidden = true
        csbCaptureWindow = nil
    }
    
}
