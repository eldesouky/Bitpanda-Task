//
//  AssetTableDataSource.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import UIKit


class AssetTableDataSource: NSObject, SearchableDataSource {
	
	// MARK: - Filter
	enum Filter: Int, CaseIterable {
		case all
        case crypto
		case fiat
        case commodities
		
		/// UILabel text  title
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
		
		/// Maps AssetType to AssetTableDataSource.Filter and evaluates the type
		/// -Returns Bool of if to should be included
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
    }

	// MARK: - Props
	
	/// SearchableDataSource searchQuery prop
	var searchQuery = ""

	var assets: [AssetInterface] = []
	
	/// Asset data filter state
    var filter: Filter = .all

	/// Filtered assets data based on filter state and search query
    var filteredAssets: [AssetInterface] {
		return assets.filter{filter.shouldInclude(type: $0.type) && $0.isMatching(searchQuery: searchQuery)}
    }
	
	// MARK: - Actions
	func fetchData() {
		assets = DataManager.shared.fetchAssets()
	}
	
	/// Moves filter forward with `filters.last` as upper limit
	func moveFilterForward() {
		if let last = Filter.allCases.last?.rawValue{
			if let newVal = Filter(rawValue:  min(last, filter.rawValue + 1)), newVal != filter {
				filter =  newVal
			}
		}
	}
	
	/// Moves filter backward with `filters.first` as lower limit
	func moveFilterBackwards() {
		if let first = Filter.allCases.first?.rawValue{
			if let newVal = Filter(rawValue:  max(first, filter.rawValue - 1)), newVal != filter {
				filter =  newVal
			}
		}
	}
}

// MARK: - UITableViewDataSource
extension AssetTableDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAssets.count
    }

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let asset = filteredAssets[indexPath.row]
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: AssetTableViewCell.cellReuseIdentifier(), for: indexPath) as? AssetTableViewCell else {
			let cell = AssetTableViewCell(style: .default, reuseIdentifier: AssetTableViewCell.cellReuseIdentifier())
			cell.setCell(content: asset)
			return cell
		}
		cell.setCell(content: asset)
		return cell
		
	}
	
}
