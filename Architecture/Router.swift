//
//  Router.swift
//  Architecture
//
//  Created by Ivan Shevelev on 25/05/16.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
//

import UIKit

class Router<T: UIViewController> {
    
    weak private(set) var viewController: T?
    
    init(viewController: T) {
        self.viewController = viewController
    }
    
    func performSegue<DestinationViewControllerType>(identifier identifier: String, configurate: ((viewController: DestinationViewControllerType) -> Void)?) {
        
        self.viewController?.performSegueWithIdentifier(identifier, sender: self) { (segue) in
            
            if let navigationViewController = segue.destinationViewController as? UINavigationController {
                if let rootViewController = navigationViewController.viewControllers.first {
                    self.perform(viewController: rootViewController, byIdentifier: identifier, configurate: configurate)
                } else {
                    fatalError("segue with identifier: \(identifier) has destinationViewController as UINavigationController without viewControllers")
                }
            } else {
                self.perform(viewController: segue.destinationViewController, byIdentifier: identifier, configurate: configurate)
            }
            
        }
        
    }
    
    private func perform<DestinationViewControllerType>(viewController viewController: UIViewController, byIdentifier identifier: String, configurate: ((viewController: DestinationViewControllerType) -> Void)?) {
        guard let viewController = viewController as? DestinationViewControllerType else {
            fatalError("segue with identifier: \(identifier) doesn't has destinationViewController with type \(DestinationViewControllerType.self)")
        }
        
        configurate?(viewController: viewController)
    }
    
}
