//
//  WalletsViewController.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import UIKit



class WalletListViewController: SearchableListingViewController{

	//MARK: - Props
	let walletListDataSource: WalletListDataSource
	lazy var sumLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .label
		label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
		label.textAlignment = .center
		return label
	}()
	
	lazy var sumLabelPadded: UIView = {
		let view = UIView()
		view.backgroundColor = .systemBackground
		return view
	}()
	
	//MARK: - init
	init(title: String, dataSource: WalletListDataSource) {
		walletListDataSource = dataSource
		super.init(dataSource: dataSource, tableViewCells: [WalletAssetTableViewCell.self])
		self.title = title
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		extendedLayoutIncludesOpaqueBars = true
		setupSumLabelPadded()
	}
	
	//MARK: - UI Setup
	func setupSumLabelPadded(){
		sumLabelPadded.addSubview(sumLabel)
		sumLabel.topAnchor.constraint(equalTo: sumLabelPadded.topAnchor, constant: 10).isActive = true
		sumLabel.leadingAnchor.constraint(equalTo: sumLabelPadded.leadingAnchor, constant: 10).isActive = true
		sumLabel.trailingAnchor.constraint(equalTo: sumLabelPadded.trailingAnchor, constant: -10).isActive = true
		sumLabel.bottomAnchor.constraint(equalTo: sumLabelPadded.bottomAnchor).isActive = true
		sumLabel.text = walletListDataSource.totalSumFormatted
	}

	override func getTableHeaderStackViews() -> [UIView] {
		return [sumLabelPadded, searchBar]
	}
}


