//
//  UIImage+Multiply.swift
//  Core40
//
//  Created by Paris Pinkney on 11/13/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit

extension UIImage {

	func multiply(by color: UIColor) -> UIImage {
		UIGraphicsBeginImageContext(size)

		guard let ctx = UIGraphicsGetCurrentContext() else {
			printLog(.error, "Expected a core graphics context!", assert: true)
			return self
		}

		let rect = CGRect(origin: .zero, size: size)

		var r: CGFloat = 0
		var g: CGFloat = 0
		var b: CGFloat = 0
		var a: CGFloat = 0

		// Fill the color:
		color.getRed(&r, green: &g, blue: &b, alpha: &a)
		ctx.setFillColor(red: r, green: g, blue: b, alpha: a)
		ctx.fill(rect)

		// Flip the image y-axis to screen display coordinates:
		ctx.translateBy(x: 0, y: size.height)
		ctx.scaleBy(x: 1.0, y: -1.0)

		// Multiply the color:
		ctx.setBlendMode(.multiply)

		guard let cgImage = cgImage else {
			printLog(.error, "Expected a core graphic image!", assert: true)
			return self
		}
		ctx.draw(cgImage, in: rect)

		guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
			printLog(.error, "Expected an image!", assert: true)
			return self
		}
		UIGraphicsEndImageContext()
		return image
	}
}
