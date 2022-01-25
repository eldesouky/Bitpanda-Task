//
//  SceneDelegate.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 20.01.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
	
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(frame: UIScreen.main.bounds)
		
		let splash = SplashViewController(onCompletion: {
			let tabBarController = TabBarController()
			self.window?.rootViewController = tabBarController
		})
		self.window?.rootViewController = splash
		window?.makeKeyAndVisible()
		window?.windowScene = windowScene
		
	}
}

