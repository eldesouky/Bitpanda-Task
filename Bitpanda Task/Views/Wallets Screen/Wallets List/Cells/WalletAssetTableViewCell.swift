//
//  WalletAssetTableViewCell.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 24.01.22.
//

import UIKit

class WalletAssetTableViewCell: AssetTableViewCell {
	
	// MARK: - Props
	lazy var horizontalSeparatorView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .secondarySystemBackground
		view.isHidden = true
		return view
	}()
	
	lazy var walletIsDefault: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 9, weight: .medium)
		label.numberOfLines = 1
		label.textAlignment = .center
		label.text = "Default"
		label.textColor = .systemBackground
		label.layer.cornerRadius = 5
		label.backgroundColor = .systemYellow
		label.isHidden = true
		label.layer.masksToBounds = true
		return label
	}()
	
	// MARK: - UI Setup
	override func setupViews() {
		super.setupViews()
		setupWalletDefault()
		setupSeparatorViews()

	}
	
	func setupWalletDefault() {
		contentView.addSubview(walletIsDefault)
		walletIsDefault.topAnchor.constraint(equalTo: assetWeight.bottomAnchor, constant: 2).isActive = true
		walletIsDefault.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.bottomAnchor, constant: -10).isActive = true
		walletIsDefault.trailingAnchor.constraint(equalTo: assetWeight.trailingAnchor).isActive = true
		walletIsDefault.widthAnchor.constraint(equalToConstant: 50).isActive = true

	}
	
	func setupSeparatorViews(){
		addSubview(horizontalSeparatorView)

		horizontalSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
		horizontalSeparatorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		horizontalSeparatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
	
	// MARK: - Actions
	override func setCell(content: AssetInterface){
		super.setCell(content: content)
		if let content = content as? WalletInterface {
			self.assetWeight.text = DataFormatter.format(price: content.balance.doubleValue, withPrecision: 2)
			assetWeight.isHidden = false
		}
		else {
			assetWeight.isHidden = true
		}
		
		if let content = content as? CommodityWallet {
			self.walletIsDefault.isHidden = !content.isDefault
		}
		else {
			self.walletIsDefault.isHidden = true
		}
		
		if content.type == .fiat {
			containerView.backgroundColor = .clear
			horizontalSeparatorView.isHidden = false
		}
		else {
			containerView.backgroundColor = .secondarySystemBackground
			horizontalSeparatorView.isHidden = true
		}
	}
}
