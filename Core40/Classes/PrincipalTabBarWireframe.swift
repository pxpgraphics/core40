//
//  PrincipalTabBarWireframe.swift
//  Core40
//
//  Created by Paris Pinkney on 11/12/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit

final class PrincipalTabBarWireframe: NSObject {

	private let controller: PrincipalTabBarController

	init(controller: PrincipalTabBarController) {
		self.controller = controller
		super.init()
	}

	// MARK: Intro

	func presentIntroInterface(from viewController: UIViewController) { }
	func dismissIntroInterface(from viewController: UIViewController) { }

	// MARK: Log In

	func presentLogInInterface(from viewController: UIViewController) { }
	func dismissLogInInterface(from viewController: UIViewController) { }

	// MARK: Home

	func selectHomeInterface() {
		controller.selectedViewController = controller.homeNavigationController
	}
}

// MARK: - UIViewControllerTransitioningDelegate

extension PrincipalTabBarWireframe: UIViewControllerTransitioningDelegate {

}
