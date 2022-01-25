//
//  WalletsViewController.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 22.01.22.
//

import UIKit



class WalletListViewController: SearchableListingViewController{

	//MARK: - init
	init(title: String, dataSource: WalletListDataSource) {
		super.init(dataSource: dataSource, tableViewCells: [WalletAssetTableViewCell.self])
		self.title = title
		hidesBottomBarWhenPushed = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.navigationBar.tintColor = .label
	}

}


