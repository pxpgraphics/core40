//
//  UIImage+ImageName.swift
//  Core40
//
//  Created by Paris Pinkney on 11/13/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit

extension UIImage {

	enum ImageName: String {
		case none = ""

		// TODO: - Need licensed or royalty-free assets. This image is not approved for commercial use.
		case backgroundHome = "fitness.jpg"
	}

	convenience init(named name: ImageName) {
		self.init(named: name.rawValue)!
	}
}

// MARK: - UIImage.ImageName

extension UIImage.ImageName {

	var image: UIImage {
		return UIImage(named: rawValue) ?? UIImage()
	}
}
