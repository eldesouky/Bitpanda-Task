//
//  SplashViewController.swift
//  Bitpanda Task
//
//  Created by Mahmoud Eldesouky on 25.01.22.
//

import UIKit

class SplashViewController: UIViewController {

	//MARK: - Props
	let labelFont = "Futura Medium"
	let completion: ()->()

	lazy var entryLogo: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.image = UIImage(named: "bitpanda")
		imageView.tintColor = .label
		return imageView
	}()
	
	lazy var exitLogo: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.image = UIImage(named: "bitpandaLogo")
		imageView.tintColor = .label
		imageView.alpha = 0
		return imageView
	}()
	
	lazy var label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Task"
		label.font = UIFont(name: labelFont, size: 36)
		label.textAlignment = .center
		label.textColor = .label
		return label
	}()
	
	lazy var footerLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Mahmoud Eldesouky"
		label.font = UIFont.systemFont(ofSize: 10, weight: .light)
		label.textAlignment = .center
		label.textColor = .label
		return label
	}()
	
	
	//MARK: - init
	init(onCompletion: @escaping ()->()){
		completion = onCompletion
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground

		setupEntryLogo()
		setupExitLogo()
		setupLabel()
		setupFooterLabel()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		startAnimation()
	}
	
	//MARK: - UI Setup
	private func setupEntryLogo(){
		view.addSubview(entryLogo)

		entryLogo.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		entryLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		entryLogo.heightAnchor.constraint(equalToConstant: 50).isActive = true
		entryLogo.widthAnchor.constraint(equalTo: entryLogo.heightAnchor, multiplier: 3).isActive = true
	}
	
	func setupExitLogo(){
		view.addSubview(exitLogo)

		exitLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		exitLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		exitLogo.heightAnchor.constraint(equalToConstant: 80).isActive = true
		exitLogo.widthAnchor.constraint(equalTo: exitLogo.heightAnchor, multiplier: 1).isActive = true
	}
	
	func setupLabel(){
		view.addSubview(label)
		
		label.topAnchor.constraint(equalTo: entryLogo.bottomAnchor).isActive = true
		label.centerXAnchor.constraint(equalTo: entryLogo.centerXAnchor).isActive = true
	}
	
	func setupFooterLabel(){
		view.addSubview(footerLabel)

		footerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
		footerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	
	//MARK: - Actions
	func startAnimation() {
		
		UIView.animate(withDuration: 0.6, delay: 0.1, animations: {
			self.entryLogo.transform = CGAffineTransform(translationX: 0, y: -420)
			self.label.transform = CGAffineTransform(translationX: 0, y: 420)
			self.entryLogo.alpha = 0
			self.label.alpha = 0
			self.exitLogo.alpha = 1

		}) { _ in
			self.completion()
		}
		UIView.animate(withDuration: 0.2, delay: 0.45, animations: {
			self.footerLabel.transform = CGAffineTransform(translationX: 0, y: 60)
			self.footerLabel.alpha = 0
		})
	}
}
