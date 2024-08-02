//
//  Paramable.swift
//
//
//  Created by JJW on 2024/05/03.
//

import Foundation

public protocol Paramable {
    func toParams() -> [String: Any]
}
