//
//  GetLottoNumRequestModel.swift
//
//
//  Created by JJW on 8/2/24.
//

import Foundation

public struct GetLottoNumRequestModel: Paramable {
    /// 회차 번호
    private let drwNo: Int
    public init(
        drwNo: Int
    ) {
        self.drwNo = drwNo
    }
    
    public func toParams() -> [String : Any] {
        return [
            "method": "getLottoNumber",
            "drwNo": String(drwNo)
        ]
    }
}
