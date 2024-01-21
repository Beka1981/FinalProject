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
}

class DetailsViewModel: NSObject, ProductDetailViewModelType {
    
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

}

extension DetailsViewModel: ProductDetailViewModelInput {
}
