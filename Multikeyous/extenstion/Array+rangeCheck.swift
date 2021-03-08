//
//  Array+rangeCheck.swift
//  Reaction
//
//  Created by Yongun Lim on 2020/01/20.
//  Copyright © 2020 MK. All rights reserved.
//

import Foundation

extension Array {
    func isVaildate(target: Int) -> Bool {
        return self.count > target && !self.isEmpty && target >= 0
    }
    
    func safe(at: Int) -> Element? {
        if self.isVaildate(target: at) {
            return self[at]
        }
        return nil
    }
}
