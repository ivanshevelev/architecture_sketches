//
//  ViewControllersRoutingSwizzle.swift
//  Architecture
//
//  Created by Ivan Shevelev on 01/06/16.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
//

import UIKit

typealias ConfiguratePerformSegue = (UIStoryboardSegue) -> ()

class ConfigurateClosureWrapper {

    var value: ConfiguratePerformSegue?
    required init(value: ConfiguratePerformSegue?) {
        self.value = value
    }
}

extension UIViewController {

    struct AssociatedKey {
        static var ClosurePrepareForSegueKey = "ClosurePrepareForSegueKey"
        static var token: String = "com.architecturescatches.viewcontroller.swizzling.route"
    }
    
    typealias ConfiguratePerformSegue = (UIStoryboardSegue) -> ()
    func performSegueWithIdentifier(_ identifier: String, sender: AnyObject?, configurate: ConfiguratePerformSegue?) {
        swizzlingPrepareForSegue()
        self.configuratePerformSegue = configurate
        performSegue(withIdentifier: identifier, sender: sender)
    }
    
    fileprivate func swizzlingPrepareForSegue() {

        DispatchQueue.once(token: AssociatedKey.token) {

            let originalSelector = #selector(UIViewController.prepare(for:sender:))
            let swizzledSelector = #selector(UIViewController.closurePrepareForSegue(_:sender:))

            let instanceClass = UIViewController.self
            let originalMethod = class_getInstanceMethod(instanceClass, originalSelector)
            let swizzledMethod = class_getInstanceMethod(instanceClass, swizzledSelector)

            let didAddMethod = class_addMethod(instanceClass, originalSelector,
                                               method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

            if didAddMethod {
                class_replaceMethod(instanceClass, swizzledSelector,
                                    method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }

    }
    
    func closurePrepareForSegue(_ segue: UIStoryboardSegue, sender: AnyObject?) {
        self.configuratePerformSegue?(segue)
        self.closurePrepareForSegue(segue, sender: sender)
        self.configuratePerformSegue = nil
    }
    
    var configuratePerformSegue: ConfiguratePerformSegue? {
        get {
            let box = objc_getAssociatedObject(self, &AssociatedKey.ClosurePrepareForSegueKey) as? ConfigurateClosureWrapper
            return box?.value
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.ClosurePrepareForSegueKey, ConfigurateClosureWrapper(value: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}
