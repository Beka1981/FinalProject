//
//  LoginViewModel.swift
//  FinalApplication
//
//  Created by Admin on 18.01.24.
//

import Foundation

protocol UserViewModelProtocol {
    func loginUser(email: String, password: String) -> LoginState
}

class UserViewModel: UserViewModelProtocol {

    func loginUser(email: String, password: String) -> LoginState {
        guard !email.isEmpty, !password.isEmpty else {
            return .failure("all_fields_are_requered".localized)
        }

        if !email.isValidEmail() {
            return .failure("email_format_is_incorrect".localized)
        }

        if password.count < 8 {
            return .failure("password_must_contain_minimum_8_symbol".localized)
        }

        let userExists = fakeUserList.contains { $0.email == email && $0.password == password }
        return userExists ? .success : .failure("email_or_password_is_incorrect".localized)
    }
}
