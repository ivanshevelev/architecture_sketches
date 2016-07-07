//
//  AppRoutable.swift
//  SmartPoints
//
//  Created by Ivan Shevelev on 01/07/16.
//  Copyright © 2016 AntsyInc. All rights reserved.
//

import UIKit

protocol AppRoutable {
    func iAppear()
}

extension AppRoutable where Self: UIViewController {
    func iAppear() {
        AppRouter.defaultRouter.appearedViewController = self
    }
}
