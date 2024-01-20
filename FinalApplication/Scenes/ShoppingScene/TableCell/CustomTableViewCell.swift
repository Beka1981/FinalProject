//
//  CustomTableViewCell.swift
//  FinalApplication
//
//  Created by Admin on 20.01.24.
//

import UIKit
import SDWebImage
import TinyConstraints

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    // MARK: - Properties
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor(red: 217/255, green: 219/255, blue: 233/255, alpha: 1).cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    private lazy var stockLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    private lazy var decreaseButton: UIButton = createQuantityButton(title: "-")
    private lazy var increaseButton: UIButton = createQuantityButton(title: "+")
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private func createQuantityButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .clear
        return button
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure view
    private func layoutCell() {
        
        contentView.addSubview(cardView)
        cardView.edgesToSuperview(usingSafeArea: true)
        
        cardView.edgesToSuperview(insets: .top(10) + .left(10) + .bottom(10) + .right(10))
        contentView.clipsToBounds = false
        selectionStyle = .none
        backgroundColor = .clear
        
        cardView.addSubview(productImageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(stockLabel)
        cardView.addSubview(priceLabel)
        cardView.addSubview(decreaseButton)
        cardView.addSubview(quantityLabel)
        cardView.addSubview(increaseButton)
        
        productImageView.leading(to: cardView, offset: 15)
        productImageView.top(to: cardView, offset: 15)
        productImageView.bottom(to: cardView, offset: -15)
        productImageView.width(115)
        productImageView.height(115)
        
        titleLabel.top(to: cardView, offset: 20)
        titleLabel.leadingToTrailing(of: productImageView, offset: 16)
        
        stockLabel.leading(to: titleLabel)
        stockLabel.topToBottom(of: titleLabel, offset: 15)
        
        priceLabel.leading(to: titleLabel)
        priceLabel.topToBottom(of: stockLabel, offset: 10)
        
        increaseButton.trailingToSuperview(offset: 16)
        increaseButton.bottomToSuperview(offset: -16)
        increaseButton.width(32)
        increaseButton.height(32)
        
        quantityLabel.trailingToLeading(of: increaseButton)
        quantityLabel.centerY(to: increaseButton)
        quantityLabel.width(32)
        
        decreaseButton.trailingToLeading(of: quantityLabel)
        decreaseButton.centerY(to: quantityLabel)
        decreaseButton.width(32)
        decreaseButton.height(32)
        
    }
    
    // MARK: - Function
    func configure(with product: Product) {
        titleLabel.text = product.title
        stockLabel.text = "stock: \(product.stock)"
        priceLabel.text = "price: \(product.price)"
        quantityLabel.text = "0"
        
        if let url = URL(string: product.thumbnail) {
            productImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
}
