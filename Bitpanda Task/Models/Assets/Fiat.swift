//
//  Fiat.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import Foundation

struct Fiat: Decodable, AssetInterface {
	
	// MARK: - Props
	let symbol, name: String
	let precision: Int
	let toEurRate: String
	let hasWallets: Bool
	let logo, logoDark: String
	
	var type: AssetType {
		return.fiat
	}
	enum CodingKeys: String, CodingKey {
		case attributes = "attributes"
		case commodityAssetType = "type"
	}
	
	enum FiatAttributesKeys: String, CodingKey {
		case symbol, name, precision
		case toEurRate = "to_eur_rate"
		case hasWallets = "has_wallets"
		
		// flip logo modes to match design
		case logo = "logo_dark"
		case logoDark = "logo_white"
	}
	
	// MARK: - init
	/// Manual Decoder to flatten Fiat JSON object
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let attributes = try container.nestedContainer(keyedBy: FiatAttributesKeys.self, forKey: .attributes)
		
		symbol = try attributes.decode(String.self, forKey: .symbol)
		name = try attributes.decode(String.self, forKey: .name)
		precision = try attributes.decode(Int.self, forKey: .precision)
		toEurRate = try attributes.decode(String.self, forKey: .toEurRate)
		hasWallets = try attributes.decode(Bool.self, forKey: .hasWallets)
		logo = try attributes.decode(String.self, forKey: .logo)
		logoDark = try attributes.decode(String.self, forKey: .logoDark)
	}
}
