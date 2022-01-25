//
//  AssetsViewController.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 21.01.22.
//

import UIKit

class AssetsViewController: SearchableListingViewController{

	//MARK: - Props
	private var assetTableDataSource = AssetTableDataSource()

	private lazy var segmentedControl: UISegmentedControl = {
		let segmentedControl = UISegmentedControl(items: AssetTableDataSource.Filter.allCases.map {$0.label})
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		segmentedControl.selectedSegmentIndex = assetTableDataSource.filter.rawValue
		segmentedControl.apportionsSegmentWidthsByContent = true
		segmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
		return segmentedControl
	}()
	
	lazy var segmentedControlPadded: UIView = {
		let view = UIView()
		view.backgroundColor = .systemBackground
		return view
	}()
	
	//MARK: - init
	init() {
		super.init(dataSource: assetTableDataSource, tableViewCells: [AssetTableViewCell.self])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		setupSwipeGestures()
		setupSegmentedControlPadded()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		reloadData(withAnimation: false)
	}
	
	//MARK: - UI Setup
	
	/// sets tableView horizontal swipe gestures targets
	private func setupSwipeGestures(){
		let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleLeftSwipe))
		swipeLeftRecognizer.direction = UISwipeGestureRecognizer.Direction.left
		tableView.addGestureRecognizer(swipeLeftRecognizer)
		
		let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleRightSwipe))
		swipeRightRecognizer.direction = UISwipeGestureRecognizer.Direction.right
		tableView.addGestureRecognizer(swipeRightRecognizer)
	}
	
	/// sets up a container view for segmentedControl to manipulate its padding and align it to searchBar view
	func setupSegmentedControlPadded(){
		segmentedControlPadded.addSubview(segmentedControl)
		segmentedControl.topAnchor.constraint(equalTo: segmentedControlPadded.topAnchor).isActive = true
		segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlPadded.leadingAnchor, constant: 8).isActive = true
		segmentedControl.trailingAnchor.constraint(equalTo: segmentedControlPadded.trailingAnchor, constant: -8).isActive = true
		segmentedControl.bottomAnchor.constraint(equalTo: segmentedControlPadded.bottomAnchor, constant: -5).isActive = true
	}
	
	override func getTableHeaderStackViews() -> [UIView] {
		// append segmentedControlPadded to header
		return [searchBar, segmentedControlPadded]
	}
	
	//MARK: - Actions
	/// fetches data from source and reload the tableView
	func reloadData(withAnimation: Bool = true){
		assetTableDataSource.fetchData()
		if withAnimation {
			reloadTableViewWithAnimation()
		}
		else {
			tableView.reloadData()
		}
	}
	
	@objc private func segmentedValueChanged(_ sender:UISegmentedControl!){
		assetTableDataSource.filter =  AssetTableDataSource.Filter(rawValue:sender.selectedSegmentIndex) ?? .all
		reloadTableViewWithAnimation()
	}
	
	@objc func handleLeftSwipe(gesture: UISwipeGestureRecognizer) {
		assetTableDataSource.moveFilterForward()
		segmentedControl.selectedSegmentIndex = assetTableDataSource.filter.rawValue
		reloadTableViewWithAnimation()
	  }
	
	@objc func handleRightSwipe(gesture: UISwipeGestureRecognizer) {
		assetTableDataSource.moveFilterBackwards()
		segmentedControl.selectedSegmentIndex = assetTableDataSource.filter.rawValue
		reloadTableViewWithAnimation()
	}
}
