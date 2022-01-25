//
//  UIView+Shadow.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 25.01.22.
//

import UIKit

extension UIView {
	func setShadowFor(mode: UIUserInterfaceStyle, lightRadius: CGFloat, darkRadius: CGFloat){
		layer.shadowColor = UIColor.label.cgColor
		layer.shadowOpacity = 0.2
		layer.shadowOffset = .zero

		switch mode {
		case .dark:
			layer.shadowRadius = darkRadius
		default:
			layer.shadowRadius = lightRadius
		}
	}
}
