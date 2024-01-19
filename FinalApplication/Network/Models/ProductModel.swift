//
//  ProductModel.swift
//  FinalApplication
//
//  Created by Admin on 19.01.24.
//

import Foundation
import SwiftUI

struct ProductResponse: Codable {
    var products: [Product]?
    var total: Int?
}

struct Product: Codable {
    var id: Int
    var title: String
    var description: String
    var price: Double
    var stock: Int
    var brand: String
    var category: String
    var thumbnail: String
    let images: [String]
}

