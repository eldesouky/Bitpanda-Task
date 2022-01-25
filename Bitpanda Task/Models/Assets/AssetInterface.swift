//
//  File.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import Foundation

protocol SearchableItem {
	func isMatching(searchQuery: String) -> Bool
}

// MARK: - AssetInterface
protocol AssetInterface: SearchableItem {
	var name: String { get }
	var symbol: String { get }
	var logo: String { get }
	var logoDark: String { get }
	var type: AssetType { get }
}

// MARK: - SearchableItem
extension AssetInterface {
	func isMatching(searchQuery: String) -> Bool {
		let matchingLowerCased =  searchQuery.lowercased()
		return name.lowercased().starts(with: matchingLowerCased) || symbol.lowercased().starts(with: matchingLowerCased)
	}
}


