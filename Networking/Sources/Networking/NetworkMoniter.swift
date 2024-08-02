//
//  NetworkMoniter.swift
//
//  Created by JJW on 2024/03/07.
//

import Alamofire
import Foundation
import OSLog

class NetworkMoniter: EventMonitor {
    func requestDidResume(_ request: Request) {
        networkDebugPrint("----------🛰 NETWORK Reqeust LOG--------------")
        networkDebugPrint(
            "1️⃣ URL / Method / Header" + "\n" + "URL: "
                + (request.request?.url?.absoluteString ?? "") + "\n"
                + "Method: " + (request.request?.httpMethod ?? "") + "\n"
                + "Headers: " + "\(request.request?.allHTTPHeaderFields ?? [:])"
        )
        networkDebugPrint("----------------------------------------------------\n2️⃣ Body")
        if let body = request.request?.httpBody?.toPrettyPrintedString {
            networkDebugPrint("Body: \(body)")
        } else {
            networkDebugPrint("보낸 Body가 없습니다.")
        }
        networkDebugPrint("----------------------------------------------------\n")
    }

    func request(_: DataRequest, didParseResponse response: AFDataResponse<some Any>) {
        networkDebugPrint("              🛰 NETWORK Response LOG")
        networkDebugPrint("\n----------------------------------------------------")
        networkDebugPrint("request URL: \(response.request?.url?.absoluteString ?? "")\n")

        switch response.result {
        case .success:
            networkDebugPrint("3️⃣ 서버 연결 성공")
        case .failure:
            networkDebugPrint("3️⃣ 서버 연결 실패")
            networkDebugPrint("올바른 URL인지 확인해보세요.")
        }

        networkDebugPrint(
            "StatusCode: " + "\(response.response?.statusCode ?? 0)"
        )

        if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 400 ..< 500:
                debugPrint("❗오류 발생 : RequestError\n" + "잘못된 요청입니다. request를 재작성 해주세요.")
            case 500:
                debugPrint("❗오류 발생 : ServerError\n" + "Server에 문제가 발생했습니다.")
            default:
                break
            }
        }

        networkDebugPrint("----------------------------------------------------")
        networkDebugPrint("4️⃣ Data 확인하기")
        if let response = response.data?.toPrettyPrintedString {
            networkDebugPrint(response)
        } else {
            networkDebugPrint("❗데이터가 없거나, Encoding에 실패했습니다.")
        }
        networkDebugPrint("----------------------------------------------------")
    }

    func networkDebugPrint(_ message: String) {
        #if DEBUG
            print(message, separator: ",", terminator: "\n")
        #endif
    }
}
