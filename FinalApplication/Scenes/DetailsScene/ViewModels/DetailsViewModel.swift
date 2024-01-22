//
//  DetailsViewModel.swift
//  FinalApplication
//
//  Created by Admin on 21.01.24.
//

import Foundation

protocol ProductDetailViewModelType {
    var input: ProductDetailViewModelInput { get }
    var output: ProductDetailViewModelOutput? { get }
}

protocol ProductDetailViewModelInput {
}

protocol ProductDetailViewModelOutput {
    func reloadData(newBalance: Double)
    func showError(text: String)
}

class DetailsViewModel: NSObject, ProductDetailViewModelType {
    
    private let notificationManager: NotificationManager
    
    override init() {
        self.notificationManager = NotificationManager.shared
    }
    
    var input: ProductDetailViewModelInput { self }
    var output: ProductDetailViewModelOutput?
    
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
    
    func pay () {
        var currentUser = UserDefaultsManager.shared.getUser()!
        let cart = CartManager.shared.getCart(forUser: currentUser.id)
        let totalCost = cart.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
        if currentUser.balance >= totalCost {
            currentUser.balance -= totalCost
            UserDefaultsManager.shared.saveUser(currentUser)
            CartManager.shared.clearCart(forUser: currentUser.id)
            notificationManager.createAndScheduleNotification()
            self.output?.reloadData(newBalance: UserDefaultsManager.shared.getUser()!.balance)
        } else {
            output?.showError(text: "insufficient_balance".localized)
        }
    }
    
}

extension DetailsViewModel: ProductDetailViewModelInput {
}
