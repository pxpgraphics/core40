//
//  FontFamily.swift
//  Core40
//
//  Created by Paris Pinkney on 11/12/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit

// MARK: - FontFamilyName

protocol FontFamilyName {

	func font(size: CGFloat) -> UIFont
}

extension FontFamilyName where Self: RawRepresentable, Self.RawValue == String {

	func font(size: CGFloat) -> UIFont {
		guard let font = UIFont(name: rawValue, size: size) else {
			printLog(.error, "Expected a valid font for name: \(rawValue), size: \(size)", assert: true)
			let defaultFont = UIFont.systemFont(ofSize: size)
			return defaultFont
		}
		return font
	}
}

// MARK: - FontFamily

struct FontFamily {

	enum Helvetica: String, FontFamilyName {
		case regular = "Helvetica"
		case bold = "Helvetica-Bold"
		case thin = "Helvetica-Thin"
		case medium = "Helvetica-Medium"
	}

	enum Avenir: String, FontFamilyName {
		case black = "Avenir-Black"
		case blackOblique = "Avenir-BlackOblique"
		case book = "Avenir-Book"
		case bookOblique = "Avenir-BookOblique"
		case heavy = "Avenir-Heavy"
		case heavyOblique = "Avenir-HeavyOblique"
		case light = "Avenir-Light"
		case lightOblique = "Avenir-LightOblique"
		case medium = "Avenir-Medium"
		case mediumOblique = "Avenir-MediumOblique"
		case oblique = "Avenir-Oblique"
		case roman = "Avenir-Roman"
	}

	enum AvenirNext: String, FontFamilyName {
		case bold = "AvenirNext-Bold"
		case boldItalic = "AvenirNext-BoldItalic"
		case demiBold = "AvenirNext-DemiBold"
		case demiBoldItalic = "AvenirNext-DemiBoldItalic"
		case heavy = "AvenirNext-Heavy"
		case heavyItalic = "AvenirNext-HeavyItalic"
		case italic = "AvenirNext-Italic"
		case medium = "AvenirNext-Medium"
		case mediumItalic = "AvenirNext-MediumItalic"
		case regular = "AvenirNext-Regular"
		case ultraLight = "AvenirNext-UltraLight"
		case ultraLightItalic = "AvenirNext-UltraLightItalic"
	}

	enum AvenirNextCondensed: String, FontFamilyName {
		case bold = "AvenirNextCondensed-Bold"
		case boldItalic = "AvenirNextCondensed-BoldItalic"
		case demiBold = "AvenirNextCondensed-DemiBold"
		case demiBoldItalic = "AvenirNextCondensed-DemiBoldItalic"
		case heavy = "AvenirNextCondensed-Heavy"
		case heavyItalic = "AvenirNextCondensed-HeavyItalic"
		case italic = "AvenirNextCondensed-Italic"
		case medium = "AvenirNextCondensed-Medium"
		case mediumItalic = "AvenirNextCondensed-MediumItalic"
		case regular = "AvenirNextCondensed-Regular"
		case ultraLight = "AvenirNextCondensed-UltraLight"
		case ultraLightItalic = "AvenirNextCondensed-UltraLightItalic"
	}
}
