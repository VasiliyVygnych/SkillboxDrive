//
//  ViewModelOnboarding.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import Foundation

protocol ViewModelOnboardingProtocol: AnyObject {
    func dismiss()
    func openScreen3_2()
    func openScreen3_3()
    func openEntrance()
}
final class ViewModelOnboarding: ViewModelOnboardingProtocol {
// MARK: - Routes
    typealias Routes = EntranceRouter & OnboardingRouter & Closable 
    private var router: Routes
    init(router: Routes) {
        self.router = router
    }
    func dismiss() {
        router.close()
    }
    func openScreen3_2() {
        router.openScreen3_2()
    }
    func openScreen3_3() {
        router.openScreen3_3()
    }
    func openEntrance() {
        router.openEntrance()
    }
}
