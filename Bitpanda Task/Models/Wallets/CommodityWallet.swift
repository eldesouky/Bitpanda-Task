//
//  CommodityWallet.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import Foundation

struct CommodityWallet: Decodable, WalletInterface {
	
	// MARK: - Props
	var logo: String = ""
	var logoDark: String = ""
	var type: AssetType = .cryptoCoin
	let symbol: String
	let isDefault: Bool
	let name: String
	let deleted: Bool
	var balance: CurrencyAmount
	
	enum CodingKeys: String, CodingKey {
		case type, attributes
	}
	
	enum CommodityWalletAttributeKeys: String, CodingKey {
		case symbol = "cryptocoin_symbol"
		case balance
		case isDefault = "is_default"
		case name
		case deleted
	}
	
	// MARK: - init
	/// Manual Decoder to flatten CommodityWallet JSON object
	init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let attributes = try container.nestedContainer(keyedBy: CommodityWalletAttributeKeys.self, forKey: .attributes)
		
		symbol = try attributes.decode(String.self, forKey: .symbol)
		balance = CurrencyAmount(stringValue: try attributes.decode(String.self, forKey: .balance))
		isDefault = try attributes.decode(Bool.self, forKey: .isDefault)
		name = try attributes.decode(String.self, forKey: .name)
		deleted = try attributes.decode(Bool.self, forKey: .deleted)
	}
	
	// MARK: - Helpers
	/// Populates wallet type and logos based using symbolLogosMapper
	mutating func populate(symbolLogos: [String: (String, String)], andType type: AssetType) {
		let logos = symbolLogos[symbol, default: ("","")]
		logo = logos.0
		logoDark = logos.1
		self.type = type
	}
}
