//
//  ShoppingViewController.swift
//  FinalApplication
//
//  Created by Admin on 19.01.24.
//

import UIKit

class ShoppingViewController: UIViewController {
    
    // MARK: - Properties
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        if let iconImage = UIImage(named: "logout") {
            button.setImage(iconImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        button.imageView?.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("შეკვეთის განხილვა", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    var viewModel = ShoppingViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        viewModel.getProduct()
    }
    
    // MARK: - Setup
    private func setupLayout() {
        
        view.backgroundColor = .white
        
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        view.addSubview(logoImageView)
        view.addSubview(logoutButton)
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        logoutButton.topToSuperview(offset: -40, usingSafeArea: true)
        logoutButton.rightToSuperview(offset: -20)
        logoutButton.width(40)
        logoutButton.height(40)
        
        logoImageView.centerXToSuperview()
        logoImageView.topToSuperview(offset: -30, usingSafeArea: true)
        logoImageView.width(122)
        logoImageView.height(103)
        
        tableView.topToBottom(of: logoImageView, offset: 20)
        tableView.leftToSuperview()
        tableView.rightToSuperview()
        tableView.bottomToTop(of: checkoutButton, offset: -20)
        
        checkoutButton.height(50)
        checkoutButton.leadingToSuperview(offset: 20)
        checkoutButton.trailingToSuperview(offset: 20)
        checkoutButton.bottomToSuperview(offset: 20, usingSafeArea: true)
    }
    
    // MARK: - Actions
    @objc func logoutButtonTapped() {
        print("uraaaaaaaa")
        UserDefaults.standard.removeObject(forKey: "currentUser")
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
            let loginController = LoginController() 
            loginController.navigationItem.hidesBackButton = true
                self.navigationController?.pushViewController(loginController, animated: true)
        }
    
        
    }
}

// MARK: - Extensions
extension ShoppingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
}

//extension ShoppingViewController: WeatherViewModelDelegate {
//    
//    func productChanged() {
//        
//    }
//    
//    func showError(text: String) {
//        let alert = UIAlertController(title: "შეცდომა", message: text, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        self.present(alert, animated: true)
//    }
//    
//}
