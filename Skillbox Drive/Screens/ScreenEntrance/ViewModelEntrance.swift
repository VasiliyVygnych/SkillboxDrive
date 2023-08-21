//
//  ViewModelEntrance.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import Foundation

// MARK: - protocol ViewModelEntranceProtocol
protocol ViewModelEntranceProtocol: AnyObject {
    func dismiss()
    func openAuthorization()
}
final class ViewModelEntrance: ViewModelEntranceProtocol {
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
