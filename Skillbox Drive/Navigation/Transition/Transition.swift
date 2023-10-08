//
//  Transition.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

protocol Transition: AnyObject {
    func open(_ viewController: UIViewController,
              from: UIViewController,
              completion: (() -> Void)?)
    func close(_ viewController: UIViewController,
               completion: (() -> Void)?)
}
