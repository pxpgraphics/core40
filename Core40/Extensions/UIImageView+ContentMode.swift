//
//  UIImageView+ContentMode.swift
//  Core40
//
//  Created by Paris Pinkney on 11/13/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit

extension UIImageView {

	convenience init(image: UIImage, contentMode: UIViewContentMode) {
		self.init(image: image)
		commonInit(contentMode: contentMode)
	}

	convenience init(named name: UIImage.ImageName, contentMode: UIViewContentMode = .scaleToFill) {
		let image = UIImage(named: name)
		self.init(image: image)
		commonInit(contentMode: contentMode)
	}

	private func commonInit(contentMode: UIViewContentMode) {
		self.contentMode = contentMode
		translatesAutoresizingMaskIntoConstraints = false
	}
}
