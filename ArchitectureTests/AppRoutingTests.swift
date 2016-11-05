//
//  AppRoutingTests.swift
//  AppRoutingTests
//
//  Created by Шевелев Иван Александрович on 05/11/2016.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
//

import XCTest
import UIKit

class FakeViewController: UIViewController, AppRoutable {

}

class AppRoutingTests: XCTestCase {

    private let appRouter = AppRouter.default
    private(set) var viewController = FakeViewController()

    func test1NotAppearedControllerMustNotBeInRouter() {
        XCTAssert(appRouter.appearedViewController == nil, "Default value must be nil")
    }

    func test2AppearedControllerMustBeInRouter() {
        self.viewController.setAppeared()
        XCTAssertEqual(self.appRouter.appearedViewController, self.viewController, "appearedViewController must be viewController")
    }

}
