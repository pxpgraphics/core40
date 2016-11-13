//
//  ImageAsset.swift
//  Core40
//
//  Created by Paris Pinkney on 11/12/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit

enum ImageAsset: String {
	case none = ""
}

extension ImageAsset {

	var image: UIImage {
		return UIImage(named: rawValue) ?? UIImage()
	}
}
