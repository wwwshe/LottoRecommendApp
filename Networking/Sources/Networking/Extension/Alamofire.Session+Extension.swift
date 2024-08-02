//
//  Alamofire.Session+Extension.swift
//
//
//  Created by JJW on 2024/03/29.
//

import Alamofire

public extension Alamofire.Session {
    static var session: Session {
        Session(eventMonitors: [NetworkMoniter()])
    }
}
