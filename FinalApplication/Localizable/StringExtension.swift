//
//  StringExtension.swift
//  FinalApplication
//
//  Created by Admin on 18.01.24.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "\(self) could not be found in Localizable.strings")
    }
}
