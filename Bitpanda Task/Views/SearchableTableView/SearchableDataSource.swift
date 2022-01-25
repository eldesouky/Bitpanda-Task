//
//  SearchableDataSource.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 23.01.22.
//

import UIKit

///  Conforms that data source has  searchQuery property ti use it in filtering its list items
protocol SearchableDataSource: NSObject, UITableViewDataSource {

	var searchQuery: String {get set}
	func search(query: String)
}

// MARK: - SearchableDataSource
extension SearchableDataSource {
	func search(query: String) {
		searchQuery = query
	}
}
