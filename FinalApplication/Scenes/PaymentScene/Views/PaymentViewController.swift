//
//  PaymentViewController.swift
//  FinalApplication
//
//  Created by Admin on 22.01.24.
//

import UIKit

class PaymentViewController: UIViewController {

    var viewModel = PaymentViewModel()
    
    lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

        lazy var statusLabel: UILabel = {
            let label = UILabel()
            label.text = "payment_error".localized.uppercased()
            label.textColor = .black
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("return_back".localized.uppercased(), for: .normal)
        button.backgroundColor = UIColor(red: 68/255.0, green: 165/255.0, blue: 255/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadStatusImage(for: viewModel.status!)
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(statusImageView)
        view.addSubview(statusLabel)
        view.addSubview(backButton)
            
        statusImageView.centerXToSuperview()
        statusImageView.topToSuperview(offset: 120, usingSafeArea: true)
        statusImageView.width(135)
        statusImageView.height(135)
            
        statusLabel.topToBottom(of: statusImageView, offset: 20)
        statusLabel.leftToSuperview(offset: 16)
        statusLabel.rightToSuperview(offset: -16)
            
        backButton.bottomToSuperview(offset: -10, usingSafeArea: true)
        backButton.leftToSuperview(offset: 16)
        backButton.rightToSuperview(offset: -16)
        backButton.height(55)
        
    }
    
    @objc func didTapBackButton() {
        dismiss(animated: true, completion: nil)
       }

    func loadStatusImage(for status: Status) {
            switch status {
            case .success:
                statusImageView.image = UIImage(named: "ok")
                statusLabel.text = "payment_success".localized.uppercased()
                AudioPlayerUtility.playAudio(forResource: "success", withExtension: "mp3")
            case .failure:
                statusImageView.image = UIImage(named: "close")
                statusLabel.text = "payment_error".localized.uppercased()
            }
        }
    
}
