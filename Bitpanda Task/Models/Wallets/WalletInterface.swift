//
//  Wallet.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import Foundation

protocol WalletInterface: AssetInterface {
	var balance: CurrencyAmount  { get }
}

// MARK: - SearchableItem
extension WalletInterface {
	func isMatching(searchQuery: String) -> Bool {
		let matchingLowerCased =  searchQuery.lowercased()
		return name.lowercased().starts(with: matchingLowerCased) || symbol.lowercased().starts(with: matchingLowerCased)
	}
}
