//
//  UIColor+ColorName.swift
//  Core40
//
//  Created by Paris Pinkney on 11/12/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit

extension UIColor {

	enum ColorName: UInt32 {
		case orange = 0xf9A129ff
		case gray = 0x5a5b5eff
		case black = 0x110e0eff
	}

	convenience init(named name: ColorName, alpha: CGFloat) {
		let rgbaValue = name.rawValue
		let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
		let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
		let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	convenience init(named name: ColorName) {
		self.init(named: name, alpha: 1)
	}
}
