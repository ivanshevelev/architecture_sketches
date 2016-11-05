//
//  Router.swift
//  Architecture
//
//  Created by Ivan Shevelev on 25/05/16.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
//

import UIKit

class Router<T: UIViewController> {
    
    weak fileprivate(set) var viewController: T?
    
    init(viewController: T) {
        self.viewController = viewController
    }
    
    func performSegue<DestinationViewControllerType>(identifier: String, configurate: ((_ viewController: DestinationViewControllerType) -> Void)?) {
        
        self.viewController?.performSegueWithIdentifier(identifier, sender: self) { (segue) in
            
            if let navigationViewController = segue.destination as? UINavigationController {
                if let rootViewController = navigationViewController.viewControllers.first {
                    self.perform(viewController: rootViewController, byIdentifier: identifier, configurate: configurate)
                } else {
                    fatalError("segue with identifier: \(identifier) has destinationViewController as UINavigationController without viewControllers")
                }
            } else {
                self.perform(viewController: segue.destination, byIdentifier: identifier, configurate: configurate)
            }
            
        }
        
    }
    
    fileprivate func perform<DestinationViewControllerType>(viewController: UIViewController, byIdentifier identifier: String, configurate: ((_ viewController: DestinationViewControllerType) -> Void)?) {
        guard let viewController = viewController as? DestinationViewControllerType else {
            fatalError("segue with identifier: \(identifier) doesn't has destinationViewController with type \(DestinationViewControllerType.self)")
        }
        
        configurate?(viewController)
    }
    
}
