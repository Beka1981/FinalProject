//
//  PaymentViewModel.swift
//  FinalApplication
//
//  Created by Admin on 22.01.24.
//

import Foundation

protocol PaymentViewModelDelegate: AnyObject {
    func paymentDidSucceed()
    func paymentDidFail()
}

class PaymentViewModel: NSObject {
    
    weak var delegate: PaymentViewModelDelegate?
    
    var status: Status?
    
    func viewIsLoaded() {
        getData ()
    }
    
    func getData () {
        switch status {
        case .success:
            self.delegate?.paymentDidSucceed()
        case .failure:
            self.delegate?.paymentDidFail()
        default: break
        }
    }
    
}




