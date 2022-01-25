//
//  SearchableTableViewController.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 23.01.22.
//

import UIKit

extension UITableViewCell {
	
	class func cellReuseIdentifier() -> String {
		return "\(self)"
	}
}

class SearchableListingViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
	//MARK: - Props
	lazy var searchBar: UISearchBar = {
		let searchBar = UISearchBar()
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		searchBar.delegate = self
		searchBar.searchBarStyle = .minimal
		return searchBar
	}()
		
	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.dataSource = dataSource
		tableView.delegate = self
		tableView.sectionHeaderTopPadding = .leastNormalMagnitude
		tableView.separatorStyle = .none
		tableView.backgroundColor = .systemBackground
		return tableView
	}()
	
	var dataSource: SearchableDataSource
	var tableViewCells: [UITableViewCell.Type]
	
	//MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
		self.view.addGestureRecognizer(tapGesture)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		reloadData()
	}
	
	init(dataSource: SearchableDataSource, tableViewCells: [UITableViewCell.Type]){
		self.dataSource = dataSource
		self.tableViewCells = tableViewCells
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - UI Setup
	func setupTableView() {
		view.addSubview(tableView)
		
		// register tableView cells
		for cell in tableViewCells {
//			let cellReuseIdentifier = cell.cellReuseIdentifier()
//			let nibCell = UINib(nibName: cellReuseIdentifier, bundle: nil)
//			tableView.register(nibCell, forCellReuseIdentifier: cellReuseIdentifier)
			
			tableView.register(cell.self, forCellReuseIdentifier: cell.cellReuseIdentifier())

		}
		
//		tableView.register(AssetTableViewCell.self, forCellReuseIdentifier: AssetTableDataSource.assetTableViewCell)
//		tableView.register(CommodityAssetTableViewCell.self, forCellReuseIdentifier: AssetTableDataSource.commodityAssetTableViewCell)
		
		// constraints
		tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
	}
	
	func setupSearchBar(into: UIView) {
		into.addSubview(searchBar)
		searchBar.topAnchor.constraint(equalTo: into.topAnchor, constant: -5).isActive = true
		searchBar.leftAnchor.constraint(equalTo: into.leftAnchor, constant: 10).isActive = true
		searchBar.rightAnchor.constraint(equalTo: into.rightAnchor, constant: -10).isActive = true
		searchBar.bottomAnchor.constraint(equalTo: into.bottomAnchor, constant: -5).isActive = true
		
		// workaround to target search bar dismiss button
		if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton") as? UIButton {

			 clearButton.addTarget(self, action: #selector(self.searchBarDismissIsClicked), for: .touchUpInside)
		}
	}

	//MARK: - Actions
	/// fetches data from source and reload the tableView
	func reloadData(){
		dataSource.fetchData()
		reloadTableViewWithAnimation()
	}
	
	@objc func searchBarDismissIsClicked() {
		searchBar.resignFirstResponder()
	}
	
	@objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
		searchBar.resignFirstResponder()
	}
	
	/// reloads the tableView with animation
	func reloadTableViewWithAnimation(){
		UIView.transition(with: tableView,
						  duration: 0.4,
						  options: .transitionCrossDissolve,
						  animations: { self.tableView.reloadData() })
	}

	//MARK: - UITableViewDelegate
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		setupSearchBar(into: headerView)
		headerView.backgroundColor = .systemBackground
		return headerView
	}

	//MARK: - UISearchBarDelegate
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		dataSource.search(query: searchText)
		reloadTableViewWithAnimation()
	}
}
