//
//  AppRoutable.swift
//  Architecture
//
//  Created by Ivan Shevelev on 01/07/16.
//  Copyright © 2016 AntsyInc. All rights reserved.
//

import UIKit

protocol AppRoutable {
    func setAppeared()
}

extension AppRoutable where Self: UIViewController {
    func setAppeared() {
        AppRouter.defaultRouter.appearedViewController = self
    }
}
