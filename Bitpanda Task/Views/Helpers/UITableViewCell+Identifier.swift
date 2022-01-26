//
//  UITableViewCell+Identifier.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 26.01.22.
//

import UIKit

extension UITableViewCell {
	class func cellReuseIdentifier() -> String {
		return "\(self)"
	}
}
