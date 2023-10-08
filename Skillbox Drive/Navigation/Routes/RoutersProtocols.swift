//
//  RoutersProtocols.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

protocol Closable {
    func close()
    func close(completion: (() -> Void)?)
}
protocol Dismissible {
    func dismiss()
    func dismiss(completion: (() -> Void)?)
}
protocol Routable {
    func route(to viewController: UIViewController,
    as transition: Transition)
    func route(to viewController: UIViewController,
               as transition: Transition,
               completion: (() -> Void)?)
}
protocol Router: Routable {
    var root: UIViewController? { get set }
}
