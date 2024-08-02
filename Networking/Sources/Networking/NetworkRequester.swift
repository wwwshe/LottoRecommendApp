//
//  NetworkRequester.swift
//
//  Created by JJW on 2024/03/07.
//

import Alamofire
import Foundation
import RxSwift

public class NetworkRequester {
    private var session: Session

    public init(
        session: Session = .session
    ) {
        self.session = session
    }

    public func request<T: Decodable>(
        target: LottoAPI,
        type _: T.Type,
        success: ((T?) -> Void)?,
        failure: ((Error) -> Void)?
    ) {
        session.request(
            target.makeURL(),
            method: target.method,
            parameters: target.parameters,
            encoding: target.encoding,
            headers: target.headers
        )
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case let .success(result):
                success?(result)
            case .failure(let error):
                failure?(error)
            }
        }
    }

    public func requestRx<T: Decodable>(
        target: LottoAPI,
        type: T.Type
    ) -> Single<T?> {
        let request = Single<T?>.create { [weak self] single in
            guard let self else { return Disposables.create() }
            self.request(
                target: target,
                type: type,
                success: { res in
                    single(.success(res))
                },
                failure: { error in
                    single(.failure(error))
                }
            )
            return Disposables.create()
        }
        return request
    }
}
