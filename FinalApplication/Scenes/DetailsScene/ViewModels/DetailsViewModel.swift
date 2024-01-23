//
//  DetailsViewModel.swift
//  FinalApplication
//
//  Created by Admin on 21.01.24.
//

import Foundation

protocol ProductDetailViewModelDelegate: AnyObject {
    func reloadData(newBalance: Double)
    func showError(text: String)
}

class DetailsViewModel: NSObject {
    
    weak var delegate: ProductDetailViewModelDelegate?
    
    private let notificationManager: NotificationManager
    
    override init() {
        self.notificationManager = NotificationManager.shared
    }
    
    var cart: [CartItem]?
    
    func calculateTotalAmount() -> Double {
        guard let cartItems = cart else { return 0.0 }
        
        let totalAmount = cartItems.reduce(0.0) { (total, cartItem) in
            let productPrice = cartItem.product.price
            let quantity = Double(cartItem.quantity)
            return total + (productPrice * quantity)
        }
        
        return totalAmount
    }
    
    func pay() {
        guard var currentUser = UserDefaultsManager.shared.getUser() else {
            delegate?.showError(text: "user_not_found".localized)
            return
        }
        
        let cart = CartManager.shared.getCart(forUser: currentUser.id)
        let totalCost = cart.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
        
        if currentUser.balance >= totalCost {
            currentUser.balance -= totalCost
            UserDefaultsManager.shared.saveUser(currentUser)
            CartManager.shared.clearCart(forUser: currentUser.id)
            notificationManager.createAndScheduleNotification()
            
            if let updatedUser = UserDefaultsManager.shared.getUser() {
                delegate?.reloadData(newBalance: updatedUser.balance)
            }
        } else {
            delegate?.showError(text: "insufficient_balance".localized)
        }
    }
    
}
