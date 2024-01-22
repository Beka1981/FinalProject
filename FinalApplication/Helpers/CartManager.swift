//
//  CartManager.swift
//  FinalApplication
//
//  Created by Admin on 21.01.24.
//

import Foundation

class CartManager {
   
    static let shared = CartManager()
    
    private init() {}
    
    func getCart(forUser userId: Int) -> [CartItem] {
        if let cartData = UserDefaults.standard.object(forKey: "cart_\(userId)") as? Data,
           let cartItems = try? JSONDecoder().decode([CartItem].self, from: cartData) {
            return cartItems
        }
        return []
    }
    
    func saveCart(_ cart: [CartItem], forUser userId: Int) {
        if let encodedData = try? JSONEncoder().encode(cart) {
            UserDefaults.standard.set(encodedData, forKey: "cart_\(userId)")
        }
    }
    
    func addToCart(product: Product, forUser userId: Int) {
        var cart = getCart(forUser: userId)
        if let index = cart.firstIndex(where: { $0.product.id == product.id }) {
            cart[index].quantity += 1
        } else {
            cart.append(CartItem(product: product, quantity: 1))
        }
        saveCart(cart, forUser: userId)
    }
    
    func removeFromCart(product: Product, forUser userId: Int) {
        var cart = getCart(forUser: userId)
        if let index = cart.firstIndex(where: { $0.product.id == product.id }) {
            if cart[index].quantity > 1 {
                cart[index].quantity -= 1
            } else {
                cart.remove(at: index)
            }
        }
        saveCart(cart, forUser: userId)
    }
    
    func clearCart(forUser userId: Int) {
        UserDefaults.standard.removeObject(forKey: "cart_\(userId)")
    }
    
    func isCartEmpty(forUser userId: Int) -> Bool {
        let cart = getCart(forUser: userId)
        return cart.isEmpty
    }
}
