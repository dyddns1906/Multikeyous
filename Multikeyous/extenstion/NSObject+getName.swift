//
//  NSObject+getName.swift
//  MbnNews
//
//  Created by YongunLim on 28/02/2019.
//  Copyright © 2019 gony. All rights reserved.
//

import Foundation

/**
 클래스 이름 찾기
 */
extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}
