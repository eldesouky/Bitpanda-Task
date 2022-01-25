//
//  UserData.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 21.01.22.
//

import Foundation

struct UserData: Decodable {
	
	// MARK: - FiatWallet
	let cryptoCoins, commodities: [Commodity]
	let fiats: [Fiat]
	var wallets, commodityWallets: [CommodityWallet]
	var fiatWallets: [FiatWallet]
		
	enum CodingKeys: String, CodingKey {
		case data
	}
	
	enum UserDataKeys: String, CodingKey {
		case attributes
	}
	
	enum UserDataAttributesKeys: String, CodingKey {
		case fiats, wallets, commodities
		case cryptoCoins = "cryptocoins"
		case commodityWallets = "commodity_wallets"
		case fiatWallets = "fiatwallets"
	}
	
	// MARK: - init
	init (from decoder :Decoder) throws {

		let container = try decoder.container(keyedBy: CodingKeys.self)
		let data = try container.nestedContainer(keyedBy: UserDataKeys.self, forKey: .data)
		let attributes = try data.nestedContainer(keyedBy: UserDataAttributesKeys.self, forKey: .attributes)

		cryptoCoins = try attributes.decode([Commodity].self, forKey: .cryptoCoins)
		commodities = try attributes.decode([Commodity].self, forKey: .commodities)
		fiats = try attributes.decode([Fiat].self, forKey: .fiats)
		wallets = try attributes.decode([CommodityWallet].self, forKey: .wallets)
		commodityWallets = try attributes.decode([CommodityWallet].self, forKey: .commodityWallets)
		fiatWallets = try attributes.decode([FiatWallet].self, forKey: .fiatWallets)
		
		// populate wallet's missing data found in neighbour data
		populateWalletsNeighbourData()
	}
	

	/// Populates wallet's missing data from neighbour data
	/// - Populates:
	/// 	- wallet logo
	/// 	- wallet logo
	/// 	- wallet type
	mutating func populateWalletsNeighbourData(){
		let symbolLogos = createSymbolLogosMapper()
		
		for i in 0..<wallets.count {
			wallets[i].populate(symbolLogos: symbolLogos, andType: .cryptoCoin)
		}
		for i in 0..<commodityWallets.count {
			commodityWallets[i].populate(symbolLogos: symbolLogos, andType: .commodity)
		}
		for i in 0..<fiatWallets.count {
			fiatWallets[i].populate(symbolLogos: symbolLogos)
		}
	}
	
	/// Creates a symbolLogosMapper from assets data to be used by wallets data
	/// - Returns: symbol Logos(white, dark) key value pairs
	func createSymbolLogosMapper() -> [String: (String, String)] {
		var symbolLogos = Dictionary(uniqueKeysWithValues: commodities.map{ ($0.symbol, ($0.logo, $0.logoDark)) })

		symbolLogos.merge(Dictionary(uniqueKeysWithValues: cryptoCoins.map{ ($0.symbol, ($0.logo, $0.logoDark)) })){(current, _) in current}
		
		symbolLogos.merge(Dictionary(uniqueKeysWithValues: fiats.map{ ($0.symbol, ($0.logo, $0.logoDark)) })){(current, _) in current}

		return symbolLogos
	}
}
