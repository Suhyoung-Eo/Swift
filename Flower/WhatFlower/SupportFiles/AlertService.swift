//
//  AlertService.swift
//  WhatFlower
//
//  Created by Suhyoung Eo on 2022/01/11.
//

import UIKit

class AlertService {
    
    static let shared = AlertService()
    
    func alert(viewController: UIViewController,
                      alertTitle: String,
                      message: String?,
                      preferredStyle: UIAlertController.Style = .alert,
                      actionTitle: String,
                      style: UIAlertAction.Style = .default) {

        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: preferredStyle)
        let action = UIAlertAction(title: actionTitle, style: style, handler: nil)
        
        alert.addAction(action)

        viewController.present(alert, animated: true, completion: nil)
    }
    
    private init() {}
}
