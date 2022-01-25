//
//  AssetsViewController.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 21.01.22.
//

import UIKit

//MARK: - AssetsViewController
class AssetsViewController: UIViewController {

	//MARK: - Props
	private lazy var segmentedControl: UISegmentedControl = {
		let segmentedControl = UISegmentedControl(items: AssetTableDataSource.Filter.allCases.map {$0.label})
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		segmentedControl.selectedSegmentIndex = assetTableDataSource.filter.rawValue
		segmentedControl.isSpringLoaded = true
		segmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
		return segmentedControl
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.dataSource = assetTableDataSource
		tableView.delegate = self
		tableView.separatorStyle = .none
		tableView.backgroundColor = .systemBackground
		return tableView
	}()
	
	private lazy var assetTableDataSource = AssetTableDataSource()
	
	//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		setupTableView()
		view.backgroundColor = .systemBackground

	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		reloadData()
	}
	
	//MARK: - UI Setup
	
	private func setupTableView() {
		view.addSubview(tableView)
		tableView.register(AssetTableViewCell.self, forCellReuseIdentifier: AssetTableDataSource.assetTableViewCell)
		tableView.register(CommodityAssetTableViewCell.self, forCellReuseIdentifier: AssetTableDataSource.commodityAssetTableViewCell)
		tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
	 }
	
	//MARK: - Actions
	private func reloadData(){
		assetTableDataSource.fetchData()
		reloadTableViewWithAnimation()
	}
	
	@objc private func segmentedValueChanged(_ sender:UISegmentedControl!){
		assetTableDataSource.filter =  AssetTableDataSource.Filter(rawValue:sender.selectedSegmentIndex) ?? .all
		reloadTableViewWithAnimation()
	}
	
	private func reloadTableViewWithAnimation(){
		UIView.transition(with: tableView,
						  duration: 0.4,
						  options: .transitionCrossDissolve,
						  animations: { self.tableView.reloadData() })
	}
	   
}

//MARK: - UITableViewDelegate
extension AssetsViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		headerView.backgroundColor = .systemBackground
		setupSegmentedControl(into: headerView)
		return headerView
	}
	
	//MARK:- UI Setup
	private func setupSegmentedControl(into: UIView) {
		into.addSubview(segmentedControl)
		segmentedControl.topAnchor.constraint(equalTo: into.topAnchor, constant: 10).isActive = true
		segmentedControl.leftAnchor.constraint(equalTo: into.leftAnchor, constant: 10).isActive = true
		segmentedControl.rightAnchor.constraint(equalTo: into.rightAnchor, constant: -10).isActive = true
		segmentedControl.bottomAnchor.constraint(equalTo: into.bottomAnchor, constant: -10).isActive = true
	 }
}
