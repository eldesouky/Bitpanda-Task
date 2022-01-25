//
//  WalletTypeCell.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 23.01.22.
//

import UIKit

class WalletTypeCardView: UIView {
	
	lazy var containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 20
		view.backgroundColor = .gray
		return view
	}()
	
	lazy var walletType: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
		label.numberOfLines = 2
		label.textAlignment = .center
		return label
	}()
	
	lazy var walletIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	var type: WalletTypesViewController.Filter
	
	init(type: WalletTypesViewController.Filter){
		self.type = type
		super.init(frame: CGRect.zero)
		addViews()
		
		walletType.text = type.label
		walletIcon.image = UIImage(named: "cryptocurrencies")
	}
	
	// we have to implement this initializer, but will only ever use this class programmatically
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	private func addViews(){
		addContainerView()
		addAssetIcon()
		addAssetName()
	}
	
	private func addContainerView(){
		addSubview(containerView)
		containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
		containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
	
		containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
		containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
	}
	
	private func addAssetIcon(){
		addSubview(walletIcon)
		walletIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
		walletIcon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		walletIcon.heightAnchor.constraint(equalTo: walletIcon.widthAnchor).isActive = true
		walletIcon.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: 10).isActive = true
		walletIcon.trailingAnchor.constraint(greaterThanOrEqualTo: containerView.trailingAnchor, constant: -10).isActive = true

	}
	
	private func addAssetName(){
		addSubview(walletType)
		walletType.topAnchor.constraint(equalTo: walletIcon.bottomAnchor, constant: 10).isActive = true
		walletType.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
		walletType.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5).isActive = true

		walletType.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
	}
}
