//
//  SearchableTableViewController.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 23.01.22.
//

import UIKit
import SwiftUI

class SearchableListingViewController: UIViewController {
	
	//MARK: - Props
	var dataSource: SearchableDataSource
	var tableViewCells: [UITableViewCell.Type]
	
	lazy var searchBar: UISearchBar = {
		let searchBar = UISearchBar()
		searchBar.delegate = self
		searchBar.autocorrectionType = .no
		searchBar.searchBarStyle = .minimal
		searchBar.placeholder = "Search"
		return searchBar
	}()
		
	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.dataSource = dataSource
		tableView.delegate = self
		if #available(iOS 15.0, *) {
			tableView.sectionHeaderTopPadding = .leastNormalMagnitude
		}
		tableView.separatorStyle = .none
		tableView.backgroundColor = .systemBackground

		return tableView
	}()
	
	//MARK: - init
	init(dataSource: SearchableDataSource, tableViewCells: [UITableViewCell.Type]){
		self.dataSource = dataSource
		self.tableViewCells = tableViewCells
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTableView()
		addKeyboardDismissGesture()
		setupSearchBarDismissButton()
	}
	
	
	//MARK: - UI Setup
	func setupTableView() {
		view.addSubview(tableView)
		
		// register tableView cells
		for cell in tableViewCells {
			tableView.register(cell.self, forCellReuseIdentifier: cell.cellReuseIdentifier())
		}
		
		// constraints
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	private func createTableHeaderStackView() -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: getTableHeaderStackViews())
		stackView.backgroundColor = .systemBackground
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
		stackView.axis = .vertical
		return stackView
	}
	
	//MARK: - Actions
	private func addKeyboardDismissGesture(){
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
		self.view.addGestureRecognizer(tapGesture)
	}
	
	/// adds target to search bar dismiss button
	private func setupSearchBarDismissButton() {
		if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton") as? UIButton {

			 clearButton.addTarget(self, action: #selector(self.searchBarDismissIsClicked), for: .touchUpInside)
		}
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
	
	/// gets the list of views to be stacked vertically in header
	///  - can be overridden to customise header view
	///  - important: searchBar view must always be returned in list
	///  - returns: list of views to be stacked vertically in header
	func getTableHeaderStackViews() -> [UIView] {
		return [searchBar]
	}
}

//MARK: - UITableViewDelegate
extension SearchableListingViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return createTableHeaderStackView()
	}
}

//MARK: - UISearchBarDelegate
extension SearchableListingViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		dataSource.search(query: searchText)
		reloadTableViewWithAnimation()
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
}
