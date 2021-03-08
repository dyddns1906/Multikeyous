//
//  MasterViewModel.swift
//  Multikeyous
//
//  Created by Yongun Lim on 2021/03/08.
//

import Foundation
import RxSwift
import RxCocoa

enum TabItemType: Int {
    case keyboard = 0, mouse, presentation, setting
    
    func getViewController() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        switch self {
            case .keyboard:
                return storyboard.instantiateViewController(withIdentifier: KeyboardViewController.className) as? KeyboardViewController
                
            case .mouse:
                return storyboard.instantiateViewController(withIdentifier: MouseViewController.className) as? MouseViewController
                
            case .presentation:
                return storyboard.instantiateViewController(withIdentifier: PresentationViewController.className) as? PresentationViewController
                
            case .setting:
                return storyboard.instantiateViewController(withIdentifier: SettingViewController.className) as? SettingViewController
        }
    }
}

class MasterViewModel {
    
    let disposeBag = DisposeBag()
    let visibleTabItem = BehaviorRelay<TabItemType>(value: .keyboard)
    
}
