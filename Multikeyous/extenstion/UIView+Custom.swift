//
//  UIView+Custom.swift
//  MKDigital_iPhone
//
//  Created by YongunLim on 01/04/2019.
//  Copyright © 2019 MK. All rights reserved.
//

import UIKit
#if canImport(NVActivityIndicatorView)
import NVActivityIndicatorView
#endif

extension UIView {
    static let BORDER_TAG = 6521467
    
    func descLeftBar(size: CGSize = CGSize.zero, leftMargin: CGFloat = 0, color: UIColor = UIColor(hexString: "#DCDCDC")) {
        
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                if let name = layer.name {
                    if name.elementsEqual("descBar") {
                        layer.removeFromSuperlayer()
                    }
                }
            }
        }
        
        var conSize = self.frame.size
        if size != CGSize.zero {
            conSize = size
        }
        let circleSize:CGFloat = 3
        let width = (conSize.width / 2)
        let height = circleSize
        let prevRect = CGRect(origin: CGPoint(x: leftMargin, y: circleSize/2), size: CGSize(width: width, height: height))
        let borderLayer = CAShapeLayer()
        borderLayer.name = "descBar"
        borderLayer.frame = CGRect(origin: prevRect.origin, size: prevRect.size)
        
        let ovalRect = CGRect(x: 0, y: 0, width: circleSize, height: circleSize)
        let ovalPath = UIBezierPath()
        ovalPath.addArc(withCenter: CGPoint.zero, radius: ovalRect.width / 2, startAngle: CGFloat(180 * Double.pi/180), endAngle: CGFloat(0), clockwise: true)
        ovalPath.addLine(to: CGPoint(x: -(circleSize/2), y: 0))
        ovalPath.addLine(to: CGPoint(x: -(circleSize/2), y: (conSize.height - circleSize*2)))
        ovalPath.addArc(withCenter: CGPoint(x: 0, y: (conSize.height - circleSize*2)), radius: ovalRect.width / 2, startAngle: CGFloat(0), endAngle: CGFloat(180 * Double.pi/180), clockwise: true)
        ovalPath.addLine(to: CGPoint(x: circleSize/2, y: (conSize.height - circleSize*2)))
        ovalPath.addLine(to: CGPoint(x: circleSize/2, y: 0))
        ovalPath.close()
        let ovalTransform = CGAffineTransform(scaleX: 1, y: (ovalRect.height / ovalRect.width))
        ovalPath.apply(ovalTransform)
        borderLayer.path = ovalPath.cgPath
        borderLayer.fillColor = color.cgColor
        self.layer.addSublayer(borderLayer)
    }
    
    func addBorder(_ arr_edge: [UIRectEdge] = [.top, .bottom, .left, .right], color: UIColor = UIColor(cgColor: #colorLiteral(red: 0.9257614213, green: 0.9257614213, blue: 0.9257614213, alpha: 1)), thickness: CGFloat = 1) {
        for subview in self.subviews {
            if subview.tag == UIView.BORDER_TAG {
                subview.removeFromSuperview()
            }
        }
        for edge in arr_edge {
            let subview = UIView()
            subview.backgroundColor = color
            subview.tag = UIView.BORDER_TAG
            self.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            switch edge {
            case .top, .bottom:
                subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
                subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
                subview.heightAnchor.constraint(equalToConstant: thickness).isActive = true
                if edge == .top {
                    subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
                } else {
                    subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
                }
            case .left, .right:
                subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
                subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
                subview.widthAnchor.constraint(equalToConstant: thickness).isActive = true
                if edge == .left {
                    subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
                } else {
                    subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
                }
            default:
                break
            }
        }
    }
    
    #if canImport(NVActivityIndicatorView)
    func startLoading(fullScreen: Bool = false, type: NVActivityIndicatorType = .ballClipRotate, color: UIColor = UIColor(cgColor: #colorLiteral(red: 0.2920934558, green: 0.6003661156, blue: 1, alpha: 1)), backgroundColor: UIColor = UIColor(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)), isNetwork: Bool = false) {
        endLoading()
        if isNetwork {
            UIApplication.shared.isNetworkActivityIndicatorVisible = isNetwork
        }
        let x = (self.frame.width / 2) - 20
        let y = (self.frame.height / 2) - 20
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: x, y: y, width: 40, height: 40), type: type, color: color)
        activityIndicator.layer.zPosition = 1000
        if fullScreen {
            let backView = UIView(frame: self.frame)
            backView.backgroundColor = backgroundColor
            backView.tag = 32147774
            backView.addSubview(activityIndicator)
            self.addSubview(backView)
        } else {
            activityIndicator.tag = 32147774
            self.addSubview(activityIndicator)
        }
        self.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func endLoading(isNetwork: Bool = false) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        for subview in self.subviews {
            if subview.tag == 32147774 {
                subview.removeFromSuperview()
                return
            }
        }
    }
    #endif
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    /// 하위뷰 모두 지우기
    func setEmpty() {
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask
            
        } else {
            self.layoutIfNeeded()
            let path = UIBezierPath(roundedRect: self.frame, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    func setShadow(color:UIColor = UIColor(cgColor: #colorLiteral(red: 0.8094438148, green: 0.8094438148, blue: 0.8094438148, alpha: 1)), opacity: Float = 0.5, radius: CGFloat = 10, offset: CGSize = .zero) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
    }
    
    func fadeIn() {
        self.isHidden = false
        self.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        } completion: { (_) in
        }
    }
    
    func fadeOut() {
        self.isHidden = false
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        } completion: { (_) in
            self.isHidden = true
        }
    }
}

private class FloatingViewWindow: UIWindow {
    var continer: UIView?
    
    var floatingButtonController: UIViewController?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let continer = continer else { return false }
        let continerPoint = convert(point, to: continer)
        return continer.point(inside: continerPoint, with: event)
    }
}
