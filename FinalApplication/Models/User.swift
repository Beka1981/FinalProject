//
//  User.swift
//  FinalApplication
//
//  Created by Admin on 18.01.24.
//

import Foundation

struct User: Codable {
    var id: Int
    var email: String
    var password: String
    var balance: Double
}

let fakeUserList = [
    User(id:1, email: "user1@example.com", password: "Password123", balance:500.0),
    User(id:2, email: "user2@example.com", password: "Password123", balance:150.0),
    User(id:3, email: "user3@example.com", password: "Password123", balance:300.0),
    User(id:4, email: "user4@example.com", password: "Password123", balance:450.0),
    User(id:5, email: "user5@example.com", password: "Password123", balance: 700.0)
]
