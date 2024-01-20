//
//  ShoppingViewModel.swift
//  FinalApplication
//
//  Created by Admin on 19.01.24.
//

import Foundation
import Alamofire

protocol ProductListViewModelTypeDelegate {
    var input: ProductListViewModelInputDelegate { get }
    var output: ProductListViewModelOutputDelegate? { get set }
}

protocol ProductListViewModelInputDelegate {
    func getProduct()
}

protocol ProductListViewModelOutputDelegate {
    func reloadData()
    func showError(text: String)
}

class ShoppingViewModel: ProductListViewModelTypeDelegate {
    
    var input: ProductListViewModelInputDelegate { self }
    var output: ProductListViewModelOutputDelegate?
    
    private var products: [Product] = []
    
    var categorizedProducts: [(category: String, products: [Product])] {
        let groupedProducts = Dictionary(grouping: products, by: { $0.category })
        return groupedProducts.map { (category: $0.key, products: $0.value) }.sorted { $0.category < $1.category }
    }
    
    private func fetchProduct() {
        let urlString = "https://dummyjson.com/products"
        NetworkService.shared.getData(from: urlString) { [weak self] (result: Result<ProductResponse, NetworkManagerError>) in
            switch result {
            case .success(let productResponse):
                self?.products = productResponse.products
                self?.output?.reloadData()
            case .failure(let error):
                self?.output?.showError(text: error.description)
            }
        }
    }
    
}

extension ShoppingViewModel: ProductListViewModelInputDelegate {
    func getProduct() {
        fetchProduct()
    }
}

