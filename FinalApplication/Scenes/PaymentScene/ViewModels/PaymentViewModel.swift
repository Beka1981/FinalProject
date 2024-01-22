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
    
}

extension PaymentViewModel: PaymentViewModelInput {
    
}



