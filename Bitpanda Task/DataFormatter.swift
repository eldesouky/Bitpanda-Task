//
//  DataFormatter.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import Foundation

class DataFormatter {
	
	/// Price locale formatter
	static let priceFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.locale = Locale.current
		formatter.numberStyle = .currency
		formatter.roundingMode = .down
		return formatter
	}()
	
	/// Formats price according to current  locale
	/// - Returns: Formatted price
	static func format(price: Double, withPrecision precision: Int? = nil) -> String {
		if let precision = precision {
			DataFormatter.priceFormatter.minimumFractionDigits = precision
			DataFormatter.priceFormatter.maximumFractionDigits = precision
		}
	
		if let formattedPrice = Self.priceFormatter.string(from: price as NSNumber) {
			return formattedPrice
		}
		return ""
	}

	
}
