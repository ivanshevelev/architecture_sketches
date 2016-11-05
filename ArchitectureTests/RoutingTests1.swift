//
//  RoutingTests1.swift
//  Architecture
//
//  Created by Ivan Shevelev on 05/11/2016.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
//

import XCTest

class RoutingTests1: XCTestCase {

    static let storyboardName = "RoutingTest1"
    static let pushedViewControllerIdentifier = "testPushedController"
    static let pushSegueIdentifier = "testPush"

    private(set) var storyboard: UIStoryboard!
    private(set) var rootViewController: UIViewController!

    private(set) var router: Router<UIViewController>!
    
    override func setUp() {
        super.setUp()

        let testBundle = Bundle(for: type(of: self))

        self.storyboard = UIStoryboard(name: RoutingTests1.storyboardName, bundle: testBundle)
        guard let navigationController = self.storyboard.instantiateInitialViewController() as? UINavigationController else {
            fatalError()
        }
        guard let rootViewController = navigationController.viewControllers.first else {
            fatalError()
        }

        self.rootViewController = rootViewController

        self.router = Router(viewController: rootViewController)

    }
    
    func testConfigureCall() {
        var configurateCalled = false
        self.router.performSegue(identifier: RoutingTests1.pushSegueIdentifier) {
            [weak self] (destinationViewController) in

            guard let this = self else { return }

            configurateCalled = true
            let pushedController = this.storyboard.instantiateViewController(withIdentifier: RoutingTests1.pushedViewControllerIdentifier)

            XCTAssert(type(of: destinationViewController) === type(of: pushedController))
        }
        XCTAssert(configurateCalled)
    }
    
}
