//
//  PrincipalTabBarController.swift
//  Core40
//
//  Created by Paris Pinkney on 11/12/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit

protocol PrincipalTabBarControllerDelegate: class {

	/// Returns: The selected view controller within the tab bar controller.
	unowned var selectedNavigationController: UINavigationController { get }

	/// Returns: The selected view controller within the tab bar controller.
	unowned var selectedViewController: UIViewController { get }

	/// Returns: The top-most navigation controller on the navigation stack.
	unowned var topNavigationController: UIViewController { get }

	/// Returns: The top-most view controller on the navigation stack.
	unowned var topViewController: UIViewController { get }

	/// Returns: The wireframe that controls the flow of the navigation stack.
	unowned var principleWireframe: PrincipalTabBarWireframe { get }
}

final class PrincipalTabBarController: UITabBarController {

	weak var principalDelegate: PrincipalTabBarControllerDelegate?

	lazy var homeNavigationController: UINavigationController = {
		let homeVC = HomeViewController()
		return UINavigationController(rootViewController: homeVC)
	}()

	lazy var wireframe: PrincipalTabBarWireframe = {
		return PrincipalTabBarWireframe(controller: self)
	}()

	override init(nibName: String?, bundle: Bundle?) {
		super.init(nibName: nibName, bundle: bundle)
		viewControllers = [homeNavigationController]
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureViews()
	}

	private func configureViews() {
		configureStatusBar()
		configureTabBar()
		configureNavigationBar()
	}

	override var preferredStatusBarStyle : UIStatusBarStyle {
		return .lightContent
	}

	private func configureStatusBar() {
		UIApplication.shared.statusBarStyle = .lightContent
	}

	private func configureTabBar() {
		let blackColor = UIColor(named: .black)
		let orangeColor = UIColor(named: .orange)

		view.backgroundColor = blackColor
		tabBar.tintColor = orangeColor
		tabBar.barTintColor = blackColor
	}

	private func configureNavigationBar() {
		navigationController?.setNavigationBarHidden(true, animated: false)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		printLog(.error, "Unresolved error", assert: true)
	}
}
