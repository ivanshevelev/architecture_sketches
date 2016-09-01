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
        static var token: dispatch_once_t = 0
    }
    
    typealias ConfiguratePerformSegue = (UIStoryboardSegue) -> ()
    func performSegueWithIdentifier(identifier: String, sender: AnyObject?, configurate: ConfiguratePerformSegue?) {
        swizzlingPrepareForSegue()
        self.configuratePerformSegue = configurate
        performSegueWithIdentifier(identifier, sender: sender)
    }
    
    private func swizzlingPrepareForSegue() {
        dispatch_once(&AssociatedKey.token) {
            let originalSelector = #selector(UIViewController.prepareForSegue(_:sender:))
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
    
    func closurePrepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
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
