//
//  TabbarController.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 20.01.22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		tabBar.tintColor = .label
		tabBar.backgroundColor = .systemBackground
		setupVCs()
		
		tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
		tabBar.layer.shadowRadius = 2
		tabBar.layer.shadowColor = UIColor.black.cgColor
		tabBar.layer.shadowOpacity = 0.3
	}
	
	fileprivate func createNavController(for rootViewController: UIViewController,
													  title: String,
													  image: UIImage) -> UIViewController {
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.tabBarItem.title = title
		navController.tabBarItem.image = image
		navController.navigationBar.prefersLargeTitles = true
		navController.navigationBar.isTranslucent = false
		rootViewController.navigationItem.title = title
		return navController
	}
	
	func setupVCs() {
		   viewControllers = [
			   createNavController(for: AssetsViewController(), title: NSLocalizedString("Assets", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
			   createNavController(for: AssetsViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "person")!),
		   ]
	   }
}
