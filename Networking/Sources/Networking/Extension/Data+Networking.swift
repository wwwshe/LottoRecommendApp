//
//  Data+Networking.swift
//
//  Created by JJW on 2024/03/07.
//

import Foundation

public extension Data {
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else { return nil }
        return prettyPrintedString
    }

    func mapJSON() -> [String: Any]? {
        try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
    }
}
