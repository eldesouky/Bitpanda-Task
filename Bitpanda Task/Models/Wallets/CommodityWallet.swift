//
//  CommodityWallet.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import Foundation

// MARK: - CommodityWallet
struct CommodityWallet: Decodable {
//	let type: CommodityWalletType
	
	var logo: String = ""
	var logoDark: String = ""
	var type: WalletType = .crypto
	
	let symbol, balance: String
	let isDefault: Bool
	let name: String
	let pendingTransactionsCount: Int
	let deleted: Bool
	
	enum CodingKeys: String, CodingKey {
		case type, attributes
	}
	
	
	enum CommodityWalletAttributeKeys: String, CodingKey {
		case symbol = "cryptocoin_symbol"
		case balance
		case isDefault = "is_default"
		case name
		case pendingTransactionsCount = "pending_transactions_count"
		case deleted
	}
		
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let attributes = try container.nestedContainer(keyedBy: CommodityWalletAttributeKeys.self, forKey: .attributes)
//		commodityAssetType = try container.decode(AssetTypeNameEnum.self, forKey: .commodityAssetType)
		
		symbol = try attributes.decode(String.self, forKey: .symbol)
		balance = try attributes.decode(String.self, forKey: .balance)
		isDefault = try attributes.decode(Bool.self, forKey: .isDefault)
		name = try attributes.decode(String.self, forKey: .name)
		pendingTransactionsCount = try attributes.decode(Int.self, forKey: .pendingTransactionsCount)
		deleted = try attributes.decode(Bool.self, forKey: .deleted)
//		let logos = symbolLogoMapper[symbol, default: ("","")]
//		logo = logos.0
//		logoDark = logos.1
	}
}

enum CommodityWalletType: String, Codable {
	case wallet = "wallet"
}

