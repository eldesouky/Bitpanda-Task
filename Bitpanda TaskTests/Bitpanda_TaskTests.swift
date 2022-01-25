//
//  Bitpanda_TaskTests.swift
//  Bitpanda TaskTests
//
//  Created by Mahmoud Eldesouky on 20.01.22.
//

import XCTest
@testable import Bitpanda_Task

extension String {
	private var nonBreakingSpace: String { "\u{00a0}"}

	var nonBreakingString: String{
		return replacingOccurrences(of: " ", with: nonBreakingSpace)
	}
}
class Bitpanda_TaskTests: XCTestCase {
	
	/// Test if current DataFormatter.priceFormatter configurations delivers the  price formatting requirements
	func testPriceFormatting() throws {
		let price = 1298.99876
		
		// locale, precision, expectation
		let computations = [
			("de_De", 2, "1.298,99 €"),
			("en_US", 2, "$1,298.99"),
			("en_GB", 3, "£1,298.998"),
			("hu_HU", 2, "1 298,99 Ft")
		]

		for (locale, precision, expectation) in computations {
			DataFormatter.priceFormatter.locale = Locale(identifier: locale)
			let result = DataFormatter.format(price: price, withPrecision: precision)
			XCTAssertEqual(expectation.nonBreakingString, result, locale)
		}
	}
	
	/// test custom encoding, objects flattening and wallets logos mapping
	func testUserDataDecoding() throws {
		guard let data = DataManager.shared.readLocalFile(forName: DataManager.path) else { fatalError("Can't find json file") }

		let response = try JSONDecoder().decode(UserData.self, from: data)

		let crypto = response.cryptoCoins.first
		XCTAssertEqual(crypto?.name, "Bitcoin")
		XCTAssertEqual(crypto?.symbol, "BTC")
		XCTAssertEqual(crypto?.avgPrice, "8936.50")
		XCTAssertEqual(crypto?.type, .cryptoCoin)

		let commodities = response.commodities.first
		XCTAssertEqual(commodities?.name, "Gold")
		XCTAssertEqual(commodities?.symbol, "XAU")
		XCTAssertEqual(commodities?.avgPrice, "46.20")
		XCTAssertEqual(commodities?.type, .commodity)
		
		
		let fiat = response.fiats.first
		XCTAssertEqual(fiat?.name, "Euro")
		XCTAssertEqual(fiat?.symbol, "EUR")
		XCTAssertEqual(fiat?.type, .fiat)
		
		let cryptoWallet = response.wallets.first
		XCTAssertEqual(cryptoWallet?.name, "BTC Wallet")
		XCTAssertEqual(cryptoWallet?.symbol, "BTC")
		XCTAssertEqual(cryptoWallet?.balance.stringValue, "2.26908585")
		XCTAssertEqual(cryptoWallet?.balance.doubleValue, 2.26908585)
		XCTAssertEqual(cryptoWallet?.type, .cryptoCoin)
		XCTAssertEqual(cryptoWallet?.logo, "https://bitpanda-assets.s3-eu-west-1.amazonaws.com/static/cryptocoin/btc.svg")
		XCTAssertEqual(cryptoWallet?.logoDark, "https://bitpanda-assets.s3-eu-west-1.amazonaws.com/static/cryptocoin/btc_dark.svg")

		let commodityWallet = response.commodityWallets.first
		XCTAssertEqual(commodityWallet?.name, "Gold Wallet")
		XCTAssertEqual(commodityWallet?.symbol, "XAU")
		XCTAssertEqual(commodityWallet?.balance.stringValue, "11.22758598")
		XCTAssertEqual(commodityWallet?.balance.doubleValue, 11.22758598)
		XCTAssertEqual(commodityWallet?.type, .commodity)
		XCTAssertEqual(commodityWallet?.logo, "https://bitpanda-assets.s3-eu-west-1.amazonaws.com/static/cryptocoin/xau.svg")
		XCTAssertEqual(commodityWallet?.logoDark, "https://bitpanda-assets.s3-eu-west-1.amazonaws.com/static/cryptocoin/xau_dark.svg")

		
		let fiatWallet = response.fiats.first
		XCTAssertEqual(fiatWallet?.name, "Euro")
		XCTAssertEqual(fiatWallet?.symbol, "EUR")
		XCTAssertEqual(fiatWallet?.type, .fiat)
		XCTAssertEqual(fiatWallet?.logo, "https://bitpanda-assets.s3-eu-west-1.amazonaws.com/static/fiat/eur_dark.svg")
		XCTAssertEqual(fiatWallet?.logoDark, "https://bitpanda-assets.s3-eu-west-1.amazonaws.com/static/fiat/eur_white.svg")

	}
	
}
