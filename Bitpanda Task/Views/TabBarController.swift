//
//  TabbarController.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 20.01.22.
//

import UIKit

class TabBarController: UITabBarController {
	
	//MARK: -  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupViewControllers()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupTabBar()
	}

	//MARK: -  UI Setup
	func setupTabBar(){
		tabBar.tintColor = .label
		tabBar.backgroundColor = .systemBackground
		tabBar.isTranslucent = false
		tabBar.setShadowFor(mode: traitCollection.userInterfaceStyle, lightRadius: 2, darkRadius: 2)
	}
	
	func setupViewControllers() {
		viewControllers = [
			createNavController(for: AssetsViewController(), title: "Assets", image: UIImage(systemName: "list.bullet")!),
		   createNavController(for: WalletsViewController(), title: "Wallets", image: UIImage(systemName: "creditcard")!),
	   ]
	}
	
	private func createNavController(for viewController: UIViewController, title: String, image: UIImage) -> UIViewController {
		viewController.navigationItem.title = title
		let navController = UINavigationController(rootViewController: viewController)
		navController.tabBarItem.title = title
		navController.tabBarItem.image = image
		navController.navigationBar.isTranslucent = false
		navController.navigationBar.prefersLargeTitles = true
		navController.navigationBar.tintColor = .label
		
		// handles iOS 15 navigation translucent not working bug
		if #available(iOS 15, *) {
			let appearance = UINavigationBarAppearance()
			appearance.configureWithOpaqueBackground()
			appearance.backgroundColor = .systemBackground
			appearance.shadowColor = .clear
			navController.navigationBar.standardAppearance = appearance
			navController.navigationBar.scrollEdgeAppearance = appearance
		}

		return navController
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		tabBar.setShadowFor(mode: traitCollection.userInterfaceStyle, lightRadius: 2, darkRadius: 2)
	}
}
