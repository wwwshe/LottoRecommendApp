//
//  MainViewModel.swift
//  LottoRecommendApp
//
//  Created by jun wook on 8/2/24.
//

import Foundation
import RxSwift
import RxCocoa
import Networking
import SwiftSoup

class MainViewModel {
    private let disposeBag = DisposeBag()
    
    private let requester = NetworkRequester()
    
    public let beforeNumbers = BehaviorRelay<[String]>(value: [])
    
    public let recommendNumbers = BehaviorRelay<[String]>(value: [])
    
    public let errorMessage = PublishSubject<String>()
    
    public var beforeRound = -1
    
    private let statByNumberUrl = "https://dhlottery.co.kr/gameResult.do?method=statByNumber"
    
    init() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.settingValue()
        }
    }
    
    private func settingValue() {
        beforeRound = getBeforeRound()
        do {
            getLotto()
            try getRecommendNumbers()
        } catch {
            errorMessage.onNext(error.localizedDescription)
        }
    }
    
    private func getRecommendNumbers() throws {
        let stats = try getStats().sorted()
        
        let top10 = stats.prefix(10)
        let results = top10.map {
            $0.ball
        }
        recommendNumbers.accept(results)
    }
    
    private func getStats() throws -> [LottoStatsModel] {
        guard let url = URL(string: statByNumberUrl) else {
            throw NSError(domain: "fail", code: -1)
        }
        var result = [LottoStatsModel]()
        let encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))
        let eucHTML = try String(contentsOf: url, encoding: encoding)
        let doc = try SwiftSoup.parse(eucHTML)
        let rows: Elements = try doc.select("tr")
        
        // 각 tr 요소에 대해 반복
        for row in rows {
            // ball_645 sml ball 클래스 값을 추출
            guard let span = try row.select("span[class^=ball_645 sml]").first() else {
                continue
            }
            
            let ballValue = try span.text()
            // td 태그 안의 숫자값 추출
            if let td = try row.select("td").last() {
                let numericValue = try td.text()
                
                result.append(
                    LottoStatsModel(ball: ballValue, count: numericValue)
                )
            }
        }
        return result
    }
    
    private func getLotto() {
        let request = GetLottoNumRequestModel(drwNo: beforeRound)
        requester.requestRx(
            target: .getLottoNum(request: request),
            type: GetLottoNumRes.self
        )
        .subscribe(onSuccess: { [weak self] res in
            guard let self = self,
                  let res = res else { return }
            self.beforeNumbers.accept(res.numbers)
        }, onFailure: { [weak self] error in
            self?.errorMessage.onNext(error.localizedDescription)
        })
        .disposed(by: disposeBag)
    }
    
    private func getBeforeRound() -> Int {
        /// 2002.12.7
        let startDate = Date(timeIntervalSince1970: 1039219200)
        let nowDate = Date()
        let distance = startDate.distance(to: nowDate)
        let round = Int(distance / (60 * 60 * 24 * 7)) + 1
        return round
    }
}
