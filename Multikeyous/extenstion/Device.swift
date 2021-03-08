//
//  Device.swift
//  MKDigital_iPhone
//
//  Created by YongunLim on 15/05/2019.
//  Copyright © 2019 MK. All rights reserved.
//

import UIKit
import Foundation


enum OSTheme: Int {
    case Default = 0, Light, Dark
}

struct Device {
    
    static var ContryCode: String! {
        get {
            return Locale.current.languageCode ?? ""
        }
    }
    static let IS_IPAD             = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA           = UIScreen.main.scale >= 2.0
    
    static var SCREEN_SIZE: CGSize {
        get {
            return UIScreen.main.bounds.size
        }
    }
    static var SCREEN_WIDTH: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    static var SCREEN_HEIGHT: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
    static var SCREEN_MAX_LENGTH: CGFloat {
        get {
            return max(SCREEN_WIDTH, SCREEN_HEIGHT)
        }
    }
    static var SCREEN_MIN_LENGTH: CGFloat {
        get {
            return min(SCREEN_WIDTH, SCREEN_HEIGHT)
        }
    }
    
    static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
    static let IS_IPHONE_5         = IS_IPHONE && SCREEN_MAX_LENGTH == 568
    static let IS_IPHONE_6         = IS_IPHONE && SCREEN_MAX_LENGTH == 667
    static let IS_IPHONE_6P        = IS_IPHONE && SCREEN_MAX_LENGTH == 736
    static let IS_IPHONE_X         = IS_IPHONE && SCREEN_MAX_LENGTH >= 812
    static let IS_IPHONE_XR        = IS_IPHONE && SCREEN_MAX_LENGTH == 896
    
    static var TopMargin: CGFloat {
        return (IS_IPHONE_X ? (DeviceInfo.Orientation.isLandscape ? 0 : 44) : 0)
    }
    static var BottomMargin: CGFloat {
        return (IS_IPHONE_X ? (DeviceInfo.Orientation.isLandscape ? 24 : 34) : 0)
    }
    static var LeftMargin: CGFloat{
        return (IS_IPHONE_X ? (DeviceInfo.Orientation.isLandscape ? 44 : 0) : 0)
    }
    static var RightMargin: CGFloat {
        return (IS_IPHONE_X ? (DeviceInfo.Orientation.isLandscape ? 44 : 0) : 0)
    }
    static var SAFT_AREA_FRAME: CGRect {
        return CGRect(x: LeftMargin, y: TopMargin, width: SCREEN_WIDTH - (LeftMargin + RightMargin), height: SCREEN_HEIGHT - (BottomMargin + TopMargin))
    }
    
    static func SAFT_AREA_FRAME(size: CGSize = SCREEN_SIZE, point: CGPoint = CGPoint(x: LeftMargin, y: TopMargin)) -> CGRect {
        return CGRect(x: point.x, y: point.y, width: size.width - point.x, height: size.height - point.y)
    }
    
    static func platform() -> String {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0,  count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
    
    static var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the LandScape orientation
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }
}
