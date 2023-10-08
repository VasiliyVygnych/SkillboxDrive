//
//  AuthorizateViewModel.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import Foundation

final class AuthorizateViewModel: AuthorizaModelteProtocol {
// MARK: - Routes
    typealias Routes = Closable & RouterWebView
    private var router: Routes
    init(router: Routes) {
        self.router = router
    }
    func dismiss() {
        router.close()
    }
    func openAuthorization() {
        router.openAuthorization()
    }
}
