/*
 See LICENSE folder for this sample's licensing information.
 */

import UIKit

class AssetTableDataSource: NSObject {
    
	enum Filter: Int, CaseIterable {
		case all
        case crypto
		case fiat
        case commodities
        
		func shouldInclude(type: AssetType) -> Bool {

			switch self {
            case .crypto:
				return type == .cryptoCoin
            case .commodities:
                return type == .commodity
			case .fiat:
				return type == .fiat
            case .all:
                return true
            }
        }
		
		var label: String {
			switch self {
			case .crypto:
				return  "Crypto Coins"
			case .commodities:
				return "Commodities"
			case .fiat:
				return "Fiat"
			case .all:
				return "All"
			}
		}
    }

    var filter: Filter = .all

    var filteredAssets: [AssetInterface] {
		return filter == .all ? assets : assets.filter{filter.shouldInclude(type: $0.type)}
    }
	
	private var assets: [AssetInterface] = []
	
	func fetchData() {
		assets = DataManager.shared.fetchAssets()
	}
}

extension AssetTableDataSource: UITableViewDataSource {
    static let assetTableViewCell = "assetTableViewCell"
	static let commodityAssetTableViewCell = "commodityAssetTableViewCell"

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAssets.count
    }

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let asset = filteredAssets[indexPath.row]
		
//		switch asset.type {
//		case .fiat:
//			guard let cell = tableView.dequeueReusableCell(withIdentifier: AssetTableDataSource.assetTableViewCell, for: indexPath) as? AssetTableViewCell else {
//				let cell = AssetTableViewCell(style: .default, reuseIdentifier: AssetTableDataSource.assetTableViewCell)
//				cell.setCell(content: asset)
//				return cell
//			}
//			cell.setCell(content: asset)
//			return cell
//		default:
			guard let cell = tableView.dequeueReusableCell(withIdentifier: AssetTableDataSource.commodityAssetTableViewCell, for: indexPath) as? CommodityAssetTableViewCell else {
				let cell = CommodityAssetTableViewCell(style: .default, reuseIdentifier: AssetTableDataSource.commodityAssetTableViewCell)
				cell.setCell(content: asset)
				return cell
			}
			cell.setCell(content: asset)
			return cell
		//}
		
	}
	
}
