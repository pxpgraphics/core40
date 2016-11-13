//
//  UnderlinedSegmentedControl.swift
//  Core40
//
//  Created by Paris Pinkney on 11/13/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import UIKit

final class UnderlinedSegmentedControl: UIControl {

	var unselectedTextColor: UIColor = .white
	var unselectedFont: UIFont = FontFamily.AvenirNext.regular.font(size: 11)

	var selectedTextColor: UIColor = .white
	var selectedFont: UIFont = FontFamily.AvenirNext.demiBold.font(size: 11)

	var showUnderline = true
	var underlineHorizontalPadding: CGFloat = 20

	var unselectedUnderlineColor = UIColor(named: .gray)
	var selectedUnderlineColor = UIColor(named: .orange)

	var selectedIndex: Int = 0 {
		didSet { updateSegmentUI() }
	}

	private var previousSelectedIndex = -1

	private var selectedView = UIView()
	private var views: [UIView] = []

	private var selectedUnderlineLayer = CALayer()
	private var underlineLayers: [CALayer] = []

	private var labels: [UILabel] = []

	private var items: [String] = [] {
		didSet {
			setUpLabels()
			setUpViews()
		}
	}

	@available(*, unavailable)
	private init() {
		super.init(frame: .zero)
		fatalError("init() has not been implemented")
	}

	@available(*, unavailable)
	private override init(frame: CGRect) {
		super.init(frame: .zero)
		fatalError("init(frame:) has not been implemented")
	}

	init(items: [String]) {
		self.items = items.map { $0.uppercased(with: .current) }
		super.init(frame: .zero)
		setUpSubviews()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		fatalError("init(coder:) has not been implemented")
	}

	private func setUpSubviews() {
		backgroundColor = .clear
		setUpLabels()
		setUpViews()
	}

	private func setUpViews() {
		views.forEach { $0.removeFromSuperview() }
		views.removeAll(keepingCapacity: true)

		views = Array(repeating: UIView(), count: items.count)
		views[selectedIndex] = selectedView
		views.forEach { addSubview($0) }

		underlineLayers.forEach { $0.removeFromSuperlayer() }
		underlineLayers.removeAll(keepingCapacity: true)

		underlineLayers = Array(repeating: CALayer(), count: items.count)
		underlineLayers[selectedIndex] = selectedUnderlineLayer

		for (view, underlineLayer) in zip(views, underlineLayers) {
			view.layer.addSublayer(underlineLayer)
		}
	}

	private func setUpLabels() {
		labels.forEach { $0.removeFromSuperview() }
		labels.removeAll(keepingCapacity: true)

		items.forEach { text in
			let label = UILabel(frame: .zero)
			label.backgroundColor = .clear
			label.font = unselectedFont
			label.textAlignment = .center
			label.textColor = unselectedTextColor
			label.text = text

			addSubview(label)
			labels.append(label)
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layoutLabels()
		updateSegmentUI()
	}

	private func layoutLabels() {
		let count = CGFloat(items.count)
		let labelHeight = bounds.height
		let labelWidth = bounds.width / count

		for (index, label) in labels.enumerated() {
			let xOffset = CGFloat(index) * labelWidth
			let origin = CGPoint(x: xOffset + underlineHorizontalPadding, y: 0)
			let size = CGSize(width: labelWidth - (underlineHorizontalPadding * 2), height: labelHeight)
			label.frame = CGRect(origin: origin, size: size)
		}

	}

	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		for (index, label) in labels.enumerated() where label.frame.contains(point) && selectedIndex != index {
			selectedIndex = index
			sendActions(for: .valueChanged)
			return true
		}
		return false
	}

	private func updateSegmentUI() {
		guard previousSelectedIndex != selectedIndex else { return }
		previousSelectedIndex = selectedIndex

		for (index, label) in labels.enumerated() {
			// reset the labels:
			label.textColor = unselectedTextColor
			label.font = unselectedFont

			guard showUnderline else { break }

			let height: CGFloat
			let backgroundColor: UIColor
			if index == selectedIndex {
				height = 1
				label.textColor = selectedTextColor
				label.font = selectedFont
				backgroundColor = selectedUnderlineColor
			} else {
				height = 1 / UIScreen.main.scale
				backgroundColor = unselectedUnderlineColor
			}

			let underlineLayer = underlineLayers[index]
			underlineLayer.backgroundColor = backgroundColor.cgColor

			let origin = CGPoint(x: 0, y: label.frame.height)
			let size = CGSize(width: label.frame.width, height: height)
			underlineLayer.frame = CGRect(origin: origin, size: size)

			let view = views[index]
			view.layer.addSublayer(underlineLayer)
			view.frame = label.frame
		}
	}
}
