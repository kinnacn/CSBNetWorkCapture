//
//  CSBCapture.swift
//  NetworkDebugging
//
//  Created by seibin on 2020/09/06.
//  Copyright © 2020年 seibin. All rights reserved.
//

import Foundation

open class CSBCapture {
    open static let shared = CSBCapture()
    private var rootViewControllerObservationTimer: Timer?
    private var csbCaptureMainViewController: CSBCaptureMainViewController?
    
    private init() {}
    
    open func startCpature() {
        registerCSBCaptureProtocol()
        startRootViewControllerObservation()
    }
    
    open func stopCpature() {
        unregisterCSBCaptureProtocol()
        stopRootViewControllerObservation()
        hiddenMainViewController()
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
        guard let topViewController = UIApplication.shared.topViewController else {
            return
        }
        
        stopRootViewControllerObservation()
        
        showMainViewController(topViewController)
    }
    
    private func showMainViewController(_ topViewController: UIViewController) {
        let csbCaptureStoryboard = UIStoryboard(name: "CSBCapture", bundle: Bundle(for: CSBCaptureMainViewController.self))
        let mainViewController = csbCaptureStoryboard.instantiateViewController(withIdentifier: CSBCaptureMainViewController.className) as! CSBCaptureMainViewController
        mainViewController.view.backgroundColor = UIColor.clear
        mainViewController.modalPresentationStyle =  .overCurrentContext;
//        mainViewController.containerViewTop.constant = UIScreen.main.bounds.height - 50.0
        
        topViewController.present(mainViewController, animated: true, completion: nil)
        csbCaptureMainViewController = mainViewController
    }
    
    private func hiddenMainViewController() {
        csbCaptureMainViewController?.dismiss(animated: false, completion: nil)
    }
}
