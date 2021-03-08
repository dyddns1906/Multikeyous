//
//  CommonAlert.swift
//  fasttrack
//
//  Created by Yongun Lim on 2020/02/10.
//  Copyright © 2020 Yongun Lim. All rights reserved.
//

import Foundation
import UIKit

/*
 notification: 확인버튼만 있음
 confirm : 확인 취소 버튼 있음
 */
enum AlertType {
    case notification, confirm, warningConfirm
}

class CommonAlert {
    var doneButtonString = "확인"
    var cancelButtonString = "취소"
    
    private var isEnableDone = true
    private var isEnableCancel = false
    
    private var alertType:AlertType = .notification
    
    private var openner:UIViewController!
    private var alert: UIAlertController!
    private var title = ""
    private var message = ""
    
    private var doneComplete: ((UIAlertAction)->Void)?
    private var cancelComplete: ((UIAlertAction)->Void)?
    
    init(openner: UIViewController? = nil, title:String = "", message: String = "", alertType:AlertType = .notification, doneComplete: ((UIAlertAction)->Void)? = nil, cancelComplete: ((UIAlertAction)->Void)? = nil ) {
        self.openner = openner
        self.title = title
        self.message = message
        self.doneComplete = doneComplete
        self.cancelComplete = cancelComplete
        self.alertType = alertType
        setupAlert()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAlert() {
        if let openner = openner {
            self.openner = openner
        } else {
            if let window = UIApplication.shared.keyWindow, let root = window.rootViewController {
                self.openner = root
            }
        }
        self.alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func present(actions: [UIAlertAction]) {
        guard let alert = self.alert, let openner = self.openner else { return }
        for action in actions {
            alert.addAction(action)
        }
        openner.present(alert, animated: true, completion: nil)
    }
    
    func present() {
        guard let alert = self.alert, let openner = self.openner else { return }
        var doneStyle: UIAlertAction.Style = .default
        if alertType == .warningConfirm {
            doneStyle = .destructive
        }
        
        let doneAction = UIAlertAction(title: doneButtonString, style: doneStyle, handler: doneComplete)
        alert.addAction(doneAction)
        
        if alertType == .confirm || alertType == .warningConfirm {
            let cancelAction = UIAlertAction(title: cancelButtonString, style: .cancel, handler: cancelComplete)
            alert.addAction(cancelAction)
        }
        
        openner.present(alert, animated: true, completion: nil)
    }
}
