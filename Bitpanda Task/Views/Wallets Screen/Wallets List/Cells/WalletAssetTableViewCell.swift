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
		horizontalSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		horizontalSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		horizontalSeparatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}

	/// Sets Fiat Wallet's unique styling
	func setupStyleFor(type: AssetType){
		if type == .fiat {
			containerView.backgroundColor = .clear
			horizontalSeparatorView.isHidden = false
		}
		else {
			containerView.backgroundColor = .secondarySystemBackground
			horizontalSeparatorView.isHidden = true
		}
	}
	
	// MARK: - Actions
	override func setCell(content: AssetInterface){
		super.setCell(content: content)
		
		setWalletIsDefaultIfPossible()
		setupStyleFor(type: content.type)
	}

	/// Override `setAssetWeightIfPossible` with Wallet Interface's own version of asset weight if content is a WalletInterface
	override func setAssetWeightIfPossible() {
		if let content = content as? WalletInterface {
			self.assetWeight.text = DataFormatter.format(price: content.balance.doubleValue, withPrecision: 2)
			assetWeight.isHidden = false
		}
		else {
			assetWeight.isHidden = true
		}
	}
	
	/// Sets wallet isDefault tag if content is a CommodityWallet object
	func setWalletIsDefaultIfPossible() {
		if let content = content as? CommodityWallet {
			self.walletIsDefault.isHidden = !content.isDefault
		}
		else {
			self.walletIsDefault.isHidden = true
		}
	}
	
}
