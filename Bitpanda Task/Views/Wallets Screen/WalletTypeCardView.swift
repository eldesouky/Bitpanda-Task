//
//  WalletTypeCell.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 23.01.22.
//

import UIKit
import MapKit

class WalletTypeCardView: UIView {
	
	//MARK: - Props
	var type: WalletsViewController.Filter
	var target: (WalletsViewController.Filter)->()
	
	lazy var containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 20
		view.backgroundColor = .systemBackground
		return view
	}()
	
	lazy var walletType: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
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
	
	//MARK: - init
	init(type: WalletsViewController.Filter, target: @escaping (WalletsViewController.Filter)->()){
		
		self.type = type
		self.target = target
		
		super.init(frame: CGRect.zero)
		
		setupViews()
		setupContent()
		addTapGestureTarget()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - UI Setup
	private func setupViews(){
		setupContainerView()
		setupAssetIcon()
		setupAssetName()
	}
	
	private func setupContainerView(){
		addSubview(containerView)
		containerView.setShadowFor(mode: traitCollection.userInterfaceStyle, lightRadius: 10, darkRadius: 1)
		containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
		containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
		containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
		containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
	}
	
	private func setupAssetIcon(){
		addSubview(walletIcon)
		walletIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
		walletIcon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		walletIcon.heightAnchor.constraint(equalTo: walletIcon.widthAnchor).isActive = true
		walletIcon.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: 20).isActive = true
		walletIcon.trailingAnchor.constraint(greaterThanOrEqualTo: containerView.trailingAnchor, constant: -20).isActive = true
	}
	
	private func setupAssetName(){
		addSubview(walletType)
		walletType.topAnchor.constraint(equalTo: walletIcon.bottomAnchor, constant: 10).isActive = true
		walletType.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
		walletType.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5).isActive = true
		walletType.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
	}
	
	//MARK: - Actions
	private func setupContent(){
		walletType.text = type.label
		walletIcon.image = UIImage(named: type.icon)
	}
	
	func addTapGestureTarget(){
		let tap = UITapGestureRecognizer(target: self, action: #selector(cardIsClicked))
		containerView.addGestureRecognizer(tap)
	}
	
	@objc func cardIsClicked(){
		target(type)
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		containerView.setShadowFor(mode: traitCollection.userInterfaceStyle, lightRadius: 10, darkRadius: 1)
	}
}
