//
//  LoginViewModel.swift
//  FinalApplication
//
//  Created by Admin on 18.01.24.
//

import Foundation

protocol UserViewModelDelegate: AnyObject {
    func loginDidSucceed(user: User)
    func loginDidFail(withErrorMessage errorMessage: String)
}

protocol UserViewModelProtocol {
    func loginUser(email: String, password: String)
}

class UserViewModel: UserViewModelProtocol {
    
    weak var delegate: UserViewModelDelegate?
    
    // MARK: - Login
    func loginUser(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            delegate?.loginDidFail(withErrorMessage: "all_fields_are_required".localized)
            return
        }
        
        if !email.isValidEmail() {
            delegate?.loginDidFail(withErrorMessage: "email_format_is_incorrect".localized)
            return
        }
        
        if password.count < 8 {
            delegate?.loginDidFail(withErrorMessage: "password_must_contain_minimum_8_characters".localized)
            return
        }
        
        if let user = fakeUserList.first(where: { $0.email == email && $0.password == password }) {
            delegate?.loginDidSucceed(user:user)
        } else {
            delegate?.loginDidFail(withErrorMessage: "email_or_password_is_incorrect".localized)
        }
    }
    
    
    // MARK: - Save User & logged status
    func saveUserToUserDefaults(_ user: User) {
        UserDefaultsManager.shared.saveUser(user)
        UserDefaultsManager.shared.setLoginStatus(true)
    }
    
}
