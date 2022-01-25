//
//  UserData.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 21.01.22.
//

import Foundation

protocol AssetInterface {
	var name: String { get }
	var symbol: String { get }
	var logo: String { get }
	var logoDark: String { get }
	var type: AssetType { get }
}

enum AssetType: Codable {
	case fiat, commodity, cryptoCoin
}

// MARK: - UserData
struct UserData: Codable {
	let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
	let attributes: DataAttributes
}

// MARK: - DataAttributes
struct DataAttributes: Codable {
	let cryptoCoins, commodities: [Commodity]
	let fiats: [Fiat]
	let wallets, commodityWallets: [Wallet]
	let fiatWallets: [Fiatwallet]
	enum CodingKeys: String, CodingKey {
		case fiats, wallets, commodities
		case cryptoCoins = "cryptocoins"
		case commodityWallets = "commodity_wallets"
		case fiatWallets = "fiatwallets"
	}
	
	func ext(){
		
	}
}



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

// MARK: - Wallet
struct Wallet: Codable {
	let type: CommodityWalletType
	let attributes: CommodityWalletAttributes
	let id: String
}

// MARK: - CommodityWalletAttributes
struct CommodityWalletAttributes: Codable {
	let cryptocoinID, cryptocoinSymbol, balance: String
	let isDefault: Bool
	let name: String
	let pendingTransactionsCount: Int
	let deleted: Bool

	enum CodingKeys: String, CodingKey {
		case cryptocoinID = "cryptocoin_id"
		case cryptocoinSymbol = "cryptocoin_symbol"
		case balance
		case isDefault = "is_default"
		case name
		case pendingTransactionsCount = "pending_transactions_count"
		case deleted
	}
}

enum CommodityWalletType: String, Codable {
	case wallet = "wallet"
}

// MARK: - Fiat
struct Fiat: Codable {
	let type: String
	let attributes: FiatAttributes
	let id: String
}

// MARK: - FiatAttributes
struct FiatAttributes: Codable, AssetInterface {
	var type: AssetType {
		return.fiat
	}
	
	let symbol, name: String
	let precision: Int
	let toEurRate, defaultSellAmount, numericCharacterReference, minWithdrawEuro: String
	let symbolCharacter: String
	let hasWallets: Bool
	let logo, logoDark, logoWhite, logoColor: String
	let nameDeu, nameEng, nameFra: String

	enum CodingKeys: String, CodingKey {
		case symbol, name, precision
		case toEurRate = "to_eur_rate"
		case defaultSellAmount = "default_sell_amount"
		case numericCharacterReference = "numeric_character_reference"
		case minWithdrawEuro = "min_withdraw_euro"
		case symbolCharacter = "symbol_character"
		case hasWallets = "has_wallets"
		case logo
		case logoDark = "logo_dark"
		case logoWhite = "logo_white"
		case logoColor = "logo_color"
		case nameDeu = "name_deu"
		case nameEng = "name_eng"
		case nameFra = "name_fra"
	}
}

// MARK: - Fiatwallet
struct Fiatwallet: Codable {
	let type: String
	let attributes: FiatwalletAttributes
	let id: String
}

// MARK: - FiatwalletAttributes
struct FiatwalletAttributes: Codable {
	let fiatID, fiatSymbol, balance, name: String
	let pendingTransactionsCount: Int

	enum CodingKeys: String, CodingKey {
		case fiatID = "fiat_id"
		case fiatSymbol = "fiat_symbol"
		case balance, name
		case pendingTransactionsCount = "pending_transactions_count"
	}
}
