//
//  LottoStatsModel.swift
//  LottoRecommendApp
//
//  Created by jun wook on 8/2/24.
//

import Foundation

struct LottoStatsModel: Comparable {
    let ball: String
    let count: String
    
    var countInt: Int {
        Int(count) ?? 0
    }
    
    static func < (lhs: LottoStatsModel, rhs: LottoStatsModel) -> Bool {
        lhs.countInt > rhs.countInt
    }
}
