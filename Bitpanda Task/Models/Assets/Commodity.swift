//
//  File.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import Foundation

struct Commodity: Decodable, AssetInterface {

	// MARK: - Props
	private let commodityAssetType: AssetTypeNameEnum
	var type: AssetType {
		return commodityAssetType == .commodity ? .commodity : .cryptoCoin
	}
	
	let symbol, name: String
	let sort: Int
	let precisionForFiatPrice: Int
	let color : String
	let logo, logoDark: String
	var avgPrice: String 
	
	enum CodingKeys: String, CodingKey {
		case attributes = "attributes"
		case commodityAssetType = "type"
	}
	
	enum CommodityAttributesKeys: String, CodingKey {
		case symbol, name, sort//, attributes
		case precisionForFiatPrice = "precision_for_fiat_price"
		case avgPrice = "avg_price"
		case color
		case logo
		case logoDark = "logo_dark"
	}
	
	// MARK: - init
	/// Manual Decoder to flatten Commodity JSON object
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let attributes = try container.nestedContainer(keyedBy: CommodityAttributesKeys.self, forKey: .attributes)
		commodityAssetType = try container.decode(AssetTypeNameEnum.self, forKey: .commodityAssetType)
		
		symbol = try attributes.decode(String.self, forKey: .symbol)
		name = try attributes.decode(String.self, forKey: .name)
		sort = try attributes.decode(Int.self, forKey: .sort)
		precisionForFiatPrice = try attributes.decode(Int.self, forKey: .precisionForFiatPrice)
		avgPrice = try attributes.decode(String.self, forKey: .avgPrice)
		color = try attributes.decode(String.self, forKey: .color)
		logo = try attributes.decode(String.self, forKey: .logo)
		logoDark = try attributes.decode(String.self, forKey: .logoDark)
	}
}

enum AssetGroupName: String, Codable {
	case coin = "coin"
	case metal = "metal"
}

enum AssetTypeNameEnum: String, Codable {
	case commodity = "commodity"
	case cryptoCoin = "cryptocoin"
}
