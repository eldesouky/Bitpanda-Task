//
//  WalletsViewController.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 23.01.22.
//

import UIKit

class WalletsViewController: UIViewController {
	
	//MARK: - Filter
	enum Filter {
		case all, crypto, commodity, fiat
		
		var label: String {
			switch self {
			case .all:
				return "All Wallets"
			case .crypto:
				return "Crypto Wallets"
			case .commodity:
				return "Commodity Wallets"
			case .fiat:
				return "Fiat Wallets"
			}
		}
		
		var icon: String {
			switch self {
			case .all:
				return "asset"
			case .crypto:
				return "cryptoWallet"
			case .commodity:
				return "commodityWallet"
			case .fiat:
				return "fiatWallet"
			}
		}
	}
	
	//MARK: - Props	
	let cardPadding = 10.0
	var wallets: [WalletInterface] = []

	lazy var containerView: UIView = {
	   let view = UIView()
	   view.translatesAutoresizingMaskIntoConstraints = false
	   view.layer.cornerRadius = 20
		view.backgroundColor = .secondarySystemBackground
	   return view
	}()
	
	lazy var horizontalSeparatorView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .systemBackground
		return view
	}()
	
	lazy var verticalSeparatorView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .systemBackground
		return view
	}()
	
	lazy var walletTypeAllView: WalletTypeCardView = {
		return createViewFor(walletType: .all)
	}()
	
	lazy var walletTypeCryptoView: WalletTypeCardView = {
		return createViewFor(walletType: .crypto)
	}()
	
	lazy var walletTypeCommodityView: WalletTypeCardView = {
		return createViewFor(walletType: .commodity)
	}()
	
	lazy var walletTypeFiatView: WalletTypeCardView = {
		return createViewFor(walletType: .fiat)
	}()
	
	//MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		wallets = DataManager.shared.fetchWallets()
		setupViews()
	}
	
	
	//MARK: - UI Setup
	func createViewFor(walletType: Filter) -> WalletTypeCardView {
		let walletTypeView = WalletTypeCardView(type: walletType, target: cardIsClicked)
		walletTypeView.translatesAutoresizingMaskIntoConstraints = false
		return walletTypeView
	}
	
	func setupViews(){
		setupContainerView()
		setupSeparatorViews()
		setupWalletTypeCards()
	}
	
	func setupContainerView(){
		view.addSubview(containerView)
		containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
		containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
		containerView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 50).isActive = true
		containerView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -150).isActive = true
	}
	
	func setupSeparatorViews(){
		containerView.addSubview(horizontalSeparatorView)
		containerView.addSubview(verticalSeparatorView)

		horizontalSeparatorView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		horizontalSeparatorView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		horizontalSeparatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		horizontalSeparatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true

		verticalSeparatorView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
		verticalSeparatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
		verticalSeparatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		verticalSeparatorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
	}
	
	func setupWalletTypeCards(){
		containerView.addSubview(walletTypeAllView)
		containerView.addSubview(walletTypeCryptoView)
		containerView.addSubview(walletTypeCommodityView)
		containerView.addSubview(walletTypeFiatView)

		walletTypeAllView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: cardPadding).isActive = true
		walletTypeCryptoView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: cardPadding).isActive = true
		walletTypeCommodityView.topAnchor.constraint(equalTo: walletTypeCryptoView.bottomAnchor, constant: cardPadding).isActive = true
		walletTypeFiatView.topAnchor.constraint(equalTo: walletTypeAllView.bottomAnchor, constant: cardPadding).isActive = true

		walletTypeAllView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: cardPadding).isActive = true
		walletTypeCryptoView.leftAnchor.constraint(equalTo: walletTypeAllView.rightAnchor, constant: cardPadding).isActive = true
		walletTypeCommodityView.leftAnchor.constraint(equalTo: walletTypeFiatView.rightAnchor, constant: cardPadding).isActive = true
		walletTypeFiatView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: cardPadding).isActive = true

		
		walletTypeAllView.rightAnchor.constraint(equalTo: walletTypeCryptoView.leftAnchor, constant: -cardPadding).isActive = true
		walletTypeCryptoView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -cardPadding).isActive = true
		walletTypeCommodityView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -cardPadding).isActive = true
		walletTypeFiatView.rightAnchor.constraint(equalTo: walletTypeCommodityView.leftAnchor, constant: -cardPadding).isActive = true

		
		walletTypeCommodityView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -cardPadding).isActive = true
		walletTypeFiatView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -cardPadding).isActive = true
		
		
		walletTypeAllView.heightAnchor.constraint(equalTo: walletTypeFiatView.heightAnchor).isActive = true
		walletTypeCryptoView.heightAnchor.constraint(equalTo: walletTypeCommodityView.heightAnchor).isActive = true

		walletTypeAllView.widthAnchor.constraint(equalTo: walletTypeCryptoView.widthAnchor).isActive = true
		walletTypeCommodityView.widthAnchor.constraint(equalTo: walletTypeFiatView.widthAnchor).isActive = true
	}

	//MARK: - Actions
	func cardIsClicked(_ filter: Filter) -> (){
		
		let data: [WalletInterface]
		
		switch filter {
		case .all:
			data = wallets
		case .crypto:
			data = wallets.filter{$0.type == .cryptoCoin}
		case .fiat:
			data = wallets.filter{$0.type == .fiat}
		case .commodity:
			data = wallets.filter{$0.type == .commodity}
		}
		
		let dataSource = WalletListDataSource(wallets: data)
		let vc = WalletListViewController(title: filter.label,  dataSource: dataSource)
		vc.hidesBottomBarWhenPushed = true
		navigationController?.pushViewController(vc, animated: true)
	}
}
