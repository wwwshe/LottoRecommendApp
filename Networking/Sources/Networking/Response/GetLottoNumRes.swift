//
//  GetLottoNumRes.swift
//
//
//  Created by JJW on 8/2/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getLottoNumRes = try? JSONDecoder().decode(GetLottoNumRes.self, from: jsonData)

import Foundation

// MARK: - GetLottoNumRes
public struct GetLottoNumRes: Codable {
    public let totSellamnt: Int?
    public let returnValue, drwNoDate: String?
    public let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int?
    public let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int?
    public let drwtNo2, drwtNo3, drwtNo1: Int?
    
    public var numbers: [String] = []
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totSellamnt = try container.decodeIfPresent(Int.self, forKey: .totSellamnt)
        self.returnValue = try container.decodeIfPresent(String.self, forKey: .returnValue)
        self.drwNoDate = try container.decodeIfPresent(String.self, forKey: .drwNoDate)
        self.firstWinamnt = try container.decodeIfPresent(Int.self, forKey: .firstWinamnt)
        self.drwtNo6 = try container.decodeIfPresent(Int.self, forKey: .drwtNo6)
        self.drwtNo4 = try container.decodeIfPresent(Int.self, forKey: .drwtNo4)
        self.firstPrzwnerCo = try container.decodeIfPresent(Int.self, forKey: .firstPrzwnerCo)
        self.drwtNo5 = try container.decodeIfPresent(Int.self, forKey: .drwtNo5)
        self.bnusNo = try container.decodeIfPresent(Int.self, forKey: .bnusNo)
        self.firstAccumamnt = try container.decodeIfPresent(Int.self, forKey: .firstAccumamnt)
        self.drwNo = try container.decodeIfPresent(Int.self, forKey: .drwNo)
        self.drwtNo2 = try container.decodeIfPresent(Int.self, forKey: .drwtNo2)
        self.drwtNo3 = try container.decodeIfPresent(Int.self, forKey: .drwtNo3)
        self.drwtNo1 = try container.decodeIfPresent(Int.self, forKey: .drwtNo1)
        
        setNumbers()
    }
    
    private mutating func setNumbers() {
        var numbers = [String]()
        let intNumbers = [drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6]
        
        intNumbers.forEach { num in
            if let num {
                numbers.append(String(num))
            } else {
                numbers.append("unknown")
            }
        }
        
        if let bnusNo {
            numbers.append(String(bnusNo) + "(Bnus)")
        } else {
            numbers.append("unknown")
        }
        
        self.numbers = numbers
    }
}
