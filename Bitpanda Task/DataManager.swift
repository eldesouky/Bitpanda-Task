//
//  DataManager.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 20.01.22.
//

import Foundation
import SwiftUI

class DataManager {
	
	/// shared instance
	static let shared = DataManager()
	
	/// data decoder
	let decoder = JSONDecoder()
	
	/// Data path/url
	static var path: String {
		return Bundle.main.infoDictionary?["DATA_URL"] as? String ?? ""
	}
	
	/// Fetches all assets
	/// - Returns: List of all Assets
	func fetchAssets() -> [AssetInterface] {
		if let data = fetchUserData() {
		
			// Filter for fiats with hasWallets
			let filteredFiatAssets = data.fiats.filter{$0.hasWallets}
			
			let allAssets: [AssetInterface] = data.commodities + data.cryptoCoins + filteredFiatAssets
			
			//sort them ascending by name
			return allAssets.sorted { $0.name < $1.name}
		}
		return []
	}
	
	/// Fetches all wallets
	/// - Returns: List of all Wallets
	func fetchWallets() -> [WalletInterface] {
		if let data = fetchUserData() {
			
			// Filter for !deleted commodityWallets
			let filteredCommodityWallets =  data.commodityWallets.filter{!$0.deleted}
			
			// Filter for !deleted wallets
			let filteredWallets = data.wallets.filter{!$0.deleted}
			
			let allWallets: [WalletInterface] = filteredCommodityWallets + filteredWallets + data.fiatWallets
			
			//sort them descending by balance
			return allWallets.sorted{ $0.balance.doubleValue > $1.balance.doubleValue }
		}
		return []
	}


	/// Fetches all user data
	/// - Returns: UserData
	private func fetchUserData() -> UserData? {
		if let data = readLocalFile(forName: DataManager.path) {
			do {
				let decodedData = try decoder.decode(UserData.self, from: data)
				return decodedData
			} catch let error {
				print(error)
				return nil
			}
		}
		return nil

	}
	
	func readLocalFile(forName name: String) -> Data? {
		do {
			if let bundlePath = Bundle.main.path(forResource: name,
												 ofType: "json"),
				let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
				return jsonData
			}
		} catch {
			print(error)
		}
		
		return nil
	}
}
