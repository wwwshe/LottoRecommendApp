//
//  Date+Time.swift
//
//
//  Created by JJW on 2024/05/08.
//

import Foundation

extension Date {
    static var currentTimeStamp: Int64 {
        Int64(Date().timeIntervalSince1970 * 1000)
    }
}
