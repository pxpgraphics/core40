//
//  UIColor+Random.swift
//  Core40
//
//  Created by Paris Pinkney on 11/12/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit

extension UIColor {

	class var random: UIColor {
		return UIColor(randomWithAlpha: 1.0)
	}

	public convenience init(randomWithAlpha alpha: CGFloat) {
		let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
		let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
		let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
		self.init(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
	}
}
