//
//  FiatWallet.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import Foundation

struct CurrencyAmount {
	
	let stringValue: String
	var doubleValue: Double {
		return Double(stringValue) ?? 0
	}
}
struct FiatWallet: Decodable, WalletInterface {
	
	// MARK: - Props
	var logo: String = ""
	var logoDark: String = ""
	let symbol, name: String
	var type: AssetType {.fiat}
	var balance: CurrencyAmount
	
	enum CodingKeys: String, CodingKey {
		case attributes
	}
	
	
	enum FiatWalletAttributesKeys: String, CodingKey {
		case symbol = "fiat_symbol"
		case balance
		case name
	}
	
	// MARK: - init
	/// Manual Decoder to flatten FiatWallet JSON object
	init (from decoder :Decoder) throws {
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let attributes = try container.nestedContainer(keyedBy: FiatWalletAttributesKeys.self, forKey: .attributes)

		symbol = try attributes.decode(String.self, forKey: .symbol)
		balance = CurrencyAmount(stringValue: try attributes.decode(String.self, forKey: .balance))
		name = try attributes.decode(String.self, forKey: .name)
	}
	
	// MARK: - Helpers
	/// Populates FiatWallet logos based using symbolLogosMapper
	mutating func populate(symbolLogos : [String: (String, String)]) {
		let logos = symbolLogos[symbol, default: ("","")]
		logo = logos.0
		logoDark = logos.1
	}
}
