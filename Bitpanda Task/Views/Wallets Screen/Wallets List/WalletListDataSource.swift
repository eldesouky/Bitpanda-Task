//
//  WalletTableDataSource.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 23.01.22.
//

import UIKit

class WalletListDataSource: NSObject, SearchableDataSource {
	
	//MARK: - Props
	var searchQuery: String = ""
	var wallets: [WalletInterface]
	var totalSumFormatted: String {
		let sum = wallets.reduce(0) {$0 + $1.balance.doubleValue}
		return DataFormatter.format(price: sum, withPrecision: 2)
	}
	
	/// Filtered assets data based on filter state and search query
	var filteredWallets: [WalletInterface] {
		return wallets.filter{$0.isMatching(searchQuery: searchQuery)}
	}
	let processor = SVGProcessor(size: CGSize(width: 30, height: 30))

	//MARK: - init
	init(wallets: [WalletInterface]) {
		self.wallets = wallets
		super.init()
	}
}

//MARK: - UITableViewDataSource
extension WalletListDataSource: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredWallets.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let wallet = filteredWallets[indexPath.row]
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: WalletAssetTableViewCell.cellReuseIdentifier(), for: indexPath) as? WalletAssetTableViewCell else {
			let cell = WalletAssetTableViewCell(style: .default, reuseIdentifier: WalletAssetTableViewCell.cellReuseIdentifier())
			cell.setCell(content: wallet)
			return cell
		}
		cell.setCell(content: wallet)
		return cell
	}
	
}

