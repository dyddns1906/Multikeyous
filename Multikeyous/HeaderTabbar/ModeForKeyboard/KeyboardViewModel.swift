//
//  KeyboardViewModel.swift
//  Multikeyous
//
//  Created by Yongun Lim on 2021/03/05.
//

import UIKit
import RxSwift
import RxCocoa

class KeyboardViewModel: NSObject {
    
    var disposeBag = DisposeBag()
    
    let keyboardHeightOb = PublishRelay<CGFloat>()
}
