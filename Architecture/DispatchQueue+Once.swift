//
//  DispatchQueue+Once.swift
//  Architecture
//
//  Created by Ivan Shevelev on 05/11/2016.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
//

import Foundation

public extension DispatchQueue {

    private static var _onceTracker = [String]()

    public class func once(token: String, block: (Void) -> Void) {
        objc_sync_enter(self);
        defer {
            objc_sync_exit(self)
        }

        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()
    }
}
