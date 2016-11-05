//
//  RoutingTests2.swift
//  Architecture
//
//  Created by Шевелев Иван Александрович on 05/11/2016.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
//

import XCTest

class RoutingTests2: XCTestCase {

    static let storyboardName = "RoutingTests2"
    static let modalledViewControllerIdentifier = "modalledController"
    static let modalSegueIdentifier = "testModal"

    private(set) var storyboard: UIStoryboard!
    private(set) var rootViewController: UIViewController!

    private(set) var router: Router<UIViewController>!
    
    override func setUp() {
        super.setUp()

        let testBundle = Bundle(for: type(of: self))

        self.storyboard = UIStoryboard(name: RoutingTests2.storyboardName, bundle: testBundle)
        guard let rootViewController = self.storyboard.instantiateInitialViewController() else {
            fatalError()
        }

        self.rootViewController = rootViewController

        self.router = Router(viewController: rootViewController)
    }
    
    func testConfigureCall() {
        var configurateCalled = false
        self.router.performSegue(identifier: RoutingTests2.modalSegueIdentifier) {
            [weak self] (destinationViewController) in

            guard let this = self else { return }

            configurateCalled = true
            guard let modalledController = this.storyboard.instantiateViewController(withIdentifier: RoutingTests2.modalledViewControllerIdentifier) as? UINavigationController else {
                XCTAssert(false)
                return
            }

            guard let viewController = modalledController.viewControllers.first else {
                XCTAssert(false)
                return
            }

            XCTAssert(type(of: viewController) === type(of: destinationViewController))
        }
        XCTAssert(configurateCalled)
    }

}
