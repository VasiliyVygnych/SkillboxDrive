//
//  Extension+String.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self,
                          tableName: "Localizable",
                          bundle: .main,
                          value: self,
                          comment: self)
    }
}
