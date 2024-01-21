//
//  LoginViewModel.swift
//  FinalApplication
//
//  Created by Admin on 18.01.24.
//

import Foundation

protocol UserViewModelProtocol {
    func loginUser(email: String, password: String) -> (LoginState, User?)
    func saveUserToUserDefaults(_ user: User)
}

class UserViewModel: UserViewModelProtocol {
    
    // MARK: - Login
    func loginUser(email: String, password: String) -> (LoginState, User?) {
        guard !email.isEmpty, !password.isEmpty else {
            return (.failure("all_fields_are_requered".localized), nil)
        }
        
        if !email.isValidEmail() {
            return (.failure("email_format_is_incorrect".localized), nil)
        }
        
        if password.count < 8 {
            return (.failure("password_must_contain_minimum_8_symbol".localized), nil)
        }
        
        if let user = fakeUserList.first(where: { $0.email == email && $0.password == password }) {
            return (.success, user)
        } else {
            return (.failure("email_or_password_is_incorrect".localized), nil)
        }
    }
    
    // MARK: - Save User & logged status
    func saveUserToUserDefaults(_ user: User) {
        UserDefaultsManager.shared.saveUser(user)
        UserDefaultsManager.shared.setLoginStatus(true)
    }
    
}
