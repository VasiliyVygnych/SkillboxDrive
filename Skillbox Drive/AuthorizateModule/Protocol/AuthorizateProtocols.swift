//
//  AuthorizateProtocols.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 07.10.2023.
//

import Foundation

protocol AuthorizaModelteProtocol: AnyObject {
    func dismiss()
    func openAuthorization()
}

protocol InputRouter {
    func openEntrance()
}

protocol AuthorizateViewControllerDelegate: AnyObject {
    func changesToken(token: String)
}

protocol ViewModelAuthorizateProtocol: AnyObject {
    func dismiss()
    func openTab()
}
