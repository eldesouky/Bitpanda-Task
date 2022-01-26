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
	
	//MARK: - Props
	static let processor = SVGProcessor(size: CGSize(width: 30, height: 30))
	var content: AssetInterface?
	
	lazy var containerView: UIView = {
	   let view = UIView()
	   view.translatesAutoresizingMaskIntoConstraints = false
	   view.layer.cornerRadius = 10
	   view.backgroundColor = .secondarySystemBackground
	   return view
	}()
	
	lazy var assetName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
		label.numberOfLines = 1
		return label
	}()
	
	lazy var assetIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.cornerRadius = 15
		imageView.contentMode = .scaleAspectFit
		imageView.image = UIImage(named: "placeholderImage")

		return imageView
	}()

	lazy var assetSymbol: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 10, weight: .light)
		label.numberOfLines = 1
		return label
	}()
	
	lazy var assetWeight: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		label.numberOfLines = 1
		return label
	}()
	
	//MARK: - init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .clear
		selectionStyle = .none
		setupViews()
		
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - UI Setup
	func setupViews(){
		setupContainerView()
		setupAssetIcon()
		setupAssetName()
		setupAssetSymbol()
		setupAssetWeight()
	}
	
	private func setupContainerView(){
		contentView.addSubview(containerView)
		containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
		containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
	
		containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
		containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
	}
	
	private func setupAssetIcon(){
		contentView.addSubview(assetIcon)
		assetIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15).isActive = true
		assetIcon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15).isActive = true
	
		assetIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
		assetIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
		assetIcon.heightAnchor.constraint(equalTo: assetIcon.widthAnchor, multiplier: 1).isActive = true

	}
	
	private func setupAssetName(){
		contentView.addSubview(assetName)
		 
		assetName.topAnchor.constraint(equalTo: assetIcon.topAnchor).isActive = true
		assetName.leadingAnchor.constraint(equalTo: assetIcon.trailingAnchor, constant: 10).isActive = true
		assetName.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -10).isActive = true
	}
	
	private func setupAssetSymbol(){
		contentView.addSubview(assetSymbol)
		
		assetSymbol.topAnchor.constraint(equalTo: assetName.bottomAnchor).isActive = true
	
		assetSymbol.leadingAnchor.constraint(equalTo: assetName.leadingAnchor).isActive = true
		assetSymbol.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -10).isActive = true
	}
	
	func setupAssetWeight() {
		contentView.addSubview(assetWeight)
		assetWeight.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		assetWeight.leadingAnchor.constraint(greaterThanOrEqualTo: assetName.trailingAnchor, constant: 10).isActive = true
		assetWeight.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
	}
	
	//MARK: - Actions
	func setCell(content: AssetInterface){
		self.content = content
		assetName.text = content.name
		assetSymbol.text = content.symbol
		setImage(traitCollection.userInterfaceStyle == .light ? content.logo : content.logoDark)
		setAssetWeightIfPossible()
	}
	
	/// Sets asset weight (as avgPrice)  if content is a Commodity object
	func setAssetWeightIfPossible() {
		if let content = content as? Commodity, let avgPriceDouble = Double(content.avgPrice) {
			assetWeight.text = DataFormatter.format(price: avgPriceDouble, withPrecision: content.precisionForFiatPrice)
			assetWeight.isHidden = false
		}
		else {
			assetWeight.isHidden = true
		}
	}
	
	func setImage(_ logo: String){
		self.assetIcon.kf.indicatorType = .activity
		self.assetIcon.kf.setImage(
			with: URL(string: logo),
			options: [
				.processor(AssetTableViewCell.processor),
				.transition(.fade(1)),
				.cacheOriginalImage
			])
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		
		guard let content = content else {return}
		
		if traitCollection.userInterfaceStyle == .dark {
			setImage(content.logoDark)
		}
		else {
			setImage(content.logo)
		}
	}
}
