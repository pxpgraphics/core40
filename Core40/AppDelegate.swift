//
//  AppDelegate.swift
//  Core40
//
//  Created by Paris Pinkney on 11/12/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	static var shared: AppDelegate {
		return UIApplication.shared.delegate as! AppDelegate
	}

	fileprivate lazy var principalTabBarController: PrincipalTabBarController = {
		let tabBarController = PrincipalTabBarController()
		tabBarController.principalDelegate = self
		return tabBarController
	}()

	fileprivate lazy var principalNavigationController: UINavigationController = {
		return UINavigationController(rootViewController: self.principalTabBarController)
	}()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		Logger.configureLoggers()
		window = makeWindow()
		return true
	}

	private func makeWindow() -> UIWindow {
		let frame = UIScreen.main.bounds
		let window = UIWindow(frame: frame)

		window.rootViewController = principalNavigationController
		window.makeKeyAndVisible()
		return window
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		// Saves changes in the application's managed object context before the application terminates.
		saveContext()
	}

	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentContainer = {
	    /*
	     The persistent container for the application. This implementation
	     creates and returns a container, having loaded the store for the
	     application to it. This property is optional since there are legitimate
	     error conditions that could cause the creation of the store to fail.
	    */
	    let container = NSPersistentContainer(name: "Core40")
	    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
	        if let error = error as NSError? {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	             
	            /*
	             Typical reasons for an error here include:
	             * The parent directory does not exist, cannot be created, or disallows writing.
	             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
	             * The device is out of space.
	             * The store could not be migrated to the current model version.
	             Check the error message to determine what the actual problem was.
	             */
				printLog(.error, "Unresolved error \(error), \(error.userInfo)", assert: true)
	        }
	    })
	    return container
	}()

	// MARK: - Core Data Saving support

	func saveContext() {
	    let context = persistentContainer.viewContext
	    if context.hasChanges {
	        do {
	            try context.save()
	        } catch {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	            let nserror = error as NSError
				printLog(.error, "Unresolved error \(nserror), \(nserror.userInfo)", assert: true)
	        }
	    }
	}
}

// MARK: - PrincipalTabBarControllerDelegate

extension AppDelegate: PrincipalTabBarControllerDelegate {

	unowned var selectedNavigationController: UINavigationController {
		guard let selectedNavController = self.principalTabBarController.selectedViewController?.navigationController else {
			printLog(.error, "Expected a selected navigation controller for \(self.principalTabBarController)", assert: true)
			return principalNavigationController
		}
		return selectedNavController
	}

	unowned var selectedViewController: UIViewController {
		guard let selectedVC = self.principalTabBarController.selectedViewController else {
			printLog(.error, "Expected a selected view controller for \(self.principalTabBarController)", assert: true)
			return principalTabBarController
		}
		return selectedVC
	}

	unowned var topNavigationController: UIViewController {
		return AppDelegate.topNavigationController(base: self.selectedNavigationController)
	}

	unowned var topViewController: UIViewController {
		return AppDelegate.topViewController(base: self.selectedViewController)
	}

	unowned var principleWireframe: PrincipalTabBarWireframe {
		return principalTabBarController.wireframe
	}

	private static func topNavigationController(base: UINavigationController = AppDelegate.shared.selectedNavigationController) -> UINavigationController {
		if let visibleNavController = base.visibleViewController?.navigationController {
			return topNavigationController(base: visibleNavController)
		}

		if let tabBarController = base.topViewController as? UITabBarController,
			let selectedNavController = tabBarController.selectedViewController?.navigationController {
			return topNavigationController(base: selectedNavController)
		}

		if let presentedNavController = base.presentedViewController?.navigationController {
			return topNavigationController(base: presentedNavController)
		}
		return base
	}

	private static func topViewController(base: UIViewController = AppDelegate.shared.selectedViewController) -> UIViewController {
		if let navController = base as? UINavigationController,
			let visibleVC = navController.visibleViewController {
			return topViewController(base: visibleVC)
		}

		if let tabBarController = base as? UITabBarController,
			let selectedVC = tabBarController.selectedViewController {
			return topViewController(base: selectedVC)
		}

		if let presentedVC = base.presentedViewController {
			return topViewController(base: presentedVC)
		}
		return base
	}
}
