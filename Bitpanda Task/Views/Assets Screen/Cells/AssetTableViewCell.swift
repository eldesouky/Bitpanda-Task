//
//  CardViewCell.swift
//  UIRevision
//
//  Created by Mahmoud Eldesouky on 19.10.21.
//

import UIKit
import Kingfisher
import PocketSVG

class AssetTableViewCell: UITableViewCell {
	
	let processor = SVGProcessor(size: CGSize(width: 30, height: 30))

	lazy var containerView: UIView = {
	   let view = UIView()
	   view.translatesAutoresizingMaskIntoConstraints = false
	   view.layer.cornerRadius = 10
	   view.backgroundColor = .assetCellColor
	   return view
	}()
	
	lazy var assetName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
		label.numberOfLines = 1
		return label
	}()
	
	private lazy var assetIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 15
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private lazy var assetSymbol: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
		label.numberOfLines = 1
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .clear
		selectionStyle = .none
		addViews()
		
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setCell(content: AssetInterface){
		
		self.assetIcon.kf.indicatorType = .activity
		self.assetIcon.kf.setImage(
			with: URL(string: content.logo),
			options: [
				.processor(processor),
				.transition(.fade(1)),
				.cacheOriginalImage
			])
		{
			result in
			switch result {
			case .failure(_):
				self.assetIcon.image = UIImage(named: "cryptocurrencies")
			default: break
			}
		}
		
		self.assetName.text = content.name
		self.assetSymbol.text = content.symbol
	}
	
	func addViews(){
		addContainerView()
		addAssetIcon()
		addAssetName()
		addAssetSymbol()
	}
	
	private func addContainerView(){
		contentView.addSubview(containerView)
		containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
		containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
	
		containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
		containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
	}
	
	private func addAssetIcon(){
		contentView.addSubview(assetIcon)
		assetIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
		assetIcon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
	
		assetIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
		assetIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
		let heightConstraint = assetIcon.heightAnchor.constraint(equalTo: assetIcon.widthAnchor, multiplier: 1)
		heightConstraint.priority = .defaultHigh
		heightConstraint.isActive = true

	}
	
	private func addAssetName(){
		contentView.addSubview(assetName)
		 
		assetName.topAnchor.constraint(equalTo: assetIcon.topAnchor).isActive = true
		assetName.leadingAnchor.constraint(equalTo: assetIcon.trailingAnchor, constant: 10).isActive = true
		assetName.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -10).isActive = true
	}
	
	private func addAssetSymbol(){
		contentView.addSubview(assetSymbol)
		
		assetSymbol.topAnchor.constraint(equalTo: assetName.bottomAnchor, constant: 0).isActive = true
	
		assetSymbol.leadingAnchor.constraint(equalTo: assetName.leadingAnchor).isActive = true
		assetSymbol.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -10).isActive = true
	}
}
