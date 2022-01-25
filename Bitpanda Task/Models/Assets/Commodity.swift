//
//  File.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import Foundation

// MARK: - Commodity
struct Commodity: Codable {
	let type: AssetTypeNameEnum
	let attributes: CommodityAttributes
	let id: String
}

// MARK: - CommodityAttributes
struct CommodityAttributes: Codable, AssetInterface {
	var type: AssetType {
		return assetTypeName == .commodity ? .commodity : .cryptoCoin
	}
	
	let symbol, name: String
	let sort: Int
	let assetTypeName: AssetTypeNameEnum
	let assetGroupName: AssetGroupName
	let precisionForFiatPrice, precisionForCoins, precisionForTx: Int
	let avgPrice: String
	let color : String
	let logo, logoDark: String
	let measurementUnit: String?
	var avgPriceFormatted: String {
		if let avgPriceDouble = Double(avgPrice) {
			return DataFormatter.format(price: avgPriceDouble, withPrecision: precisionForFiatPrice)
		}
		return ""
	}
	enum CodingKeys: String, CodingKey {
		case symbol, name, sort
		case assetTypeName = "asset_type_name"
		case assetGroupName = "asset_group_name"
		case precisionForFiatPrice = "precision_for_fiat_price"
		case precisionForCoins = "precision_for_coins"
		case precisionForTx = "precision_for_tx"
		case avgPrice = "avg_price"
		case color
		case logo
		case logoDark = "logo_dark"
		case measurementUnit = "measurement_unit"
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
