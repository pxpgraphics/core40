//
//  HomeViewController.swift
//  Core40
//
//  Created by Paris Pinkney on 11/12/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

	enum Segment : String {
		case spin = "Spin Training"
		case lagree = "Lagree Training"
	}

	lazy var segmentedControl: UnderlinedSegmentedControl = {
		let items: [Segment] = [ .spin, .lagree ]
		return UnderlinedSegmentedControl(items: items.map { $0.rawValue })
	}()

	override init(nibName: String?, bundle: Bundle?) {
		super.init(nibName: nibName, bundle: bundle)
		title = NSLocalizedString("Home", comment: "Home screen")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureViews()
		configureNavigationBar()
		configureToolbar()
	}

	private func configureViews() {
		view.backgroundColor = UIColor(named: .black)
	}

	private func configureNavigationBar() {
		navigationItem.titleView = UIView()

		// navigationController?.setNavigationBarHidden(true, animated: false)
		navigationController?.navigationBar.addSubview(segmentedControl)

		// view.addSubview(segmentedControl)
		segmentedControl.snp.makeConstraints { make in
			make.top.width.equalToSuperview()
			make.height.equalTo(44)
		}

		guard let navController = navigationController else { return }
		let clearImage = UIImage()
		navController.navigationBar.setBackgroundImage(clearImage, for: .default)
		navController.navigationBar.shadowImage = clearImage
	}

	private func configureToolbar() {

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		printLog(.error, "Unresolved error", assert: true)
	}
}

