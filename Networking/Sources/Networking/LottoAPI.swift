//
//  LottoAPI.swift
//
//  Created by jjw on 2024/03/29.
//

import Alamofire
import Foundation

public enum LottoAPI {
    case getLottoNum(request: Paramable)
}

public extension LottoAPI {
    var path: String {
        switch self {
        case .getLottoNum:
            "/common.do"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getLottoNum:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        /// API
        case let .getLottoNum(request):
            request.toParams()
        }
    }

    var encoding: ParameterEncoding {
        if method == .post {
            JSONEncoding.default
        } else {
            URLEncoding.default
        }
    }

    var headers: HTTPHeaders {
        var httpHeaders: HTTPHeaders = [:]
        httpHeaders["Content-Type"] = "application/json;charset=UTF-8"
        httpHeaders["Accept"] = "application/json"
        
        return httpHeaders
    }

    /// 풀 url 생성
    func makeURL() -> URL {
        URL(string: "http://www.dhlottery.co.kr" + path)!
    }
}
