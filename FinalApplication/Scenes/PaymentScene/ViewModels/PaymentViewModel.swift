//
//  PaymentViewModel.swift
//  FinalApplication
//
//  Created by Admin on 22.01.24.
//

import Foundation

protocol PaymentViewModelType {
    var input: PaymentViewModelInput { get }
    var output: PaymentViewModelOutput? { get }
}

protocol PaymentViewModelInput {
}

protocol PaymentViewModelOutput {
    func reloadData()
    func showError(text: String)
}

class PaymentViewModel: NSObject, PaymentViewModelType {
    
    var input: PaymentViewModelInput { self }
    var output: PaymentViewModelOutput?
    
    var status: Status?
    
    private func pay () {
        var currentUser = UserDefaultsManager.shared.getUser()!
        let cart = CartManager.shared.getCart(forUser: currentUser.id)
                let totalCost = cart.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
        if currentUser.balance >= totalCost {
            currentUser.balance -= totalCost
                    UserDefaultsManager.shared.saveUser(currentUser)
                } else {
                    output?.showError(text: "არასაკმარისი ბალანსი.")
                }
        
        CartManager.shared.clearCart(forUser: currentUser.id)
    }
}

extension PaymentViewModel: PaymentViewModelInput {

}



