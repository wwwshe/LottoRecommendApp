//
//  React+UIApplication.swift
//
//
//  Created by jun wook on 3/22/24.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

public extension Reactive where Base: UIApplication {
    var applicationWillEnterForeground: Observable<UIApplicationState> {
        return NotificationCenter.default.rx
            .notification(UIApplication.willEnterForegroundNotification)
            .map { _ in
                return .inactive
            }
    }
    
    var applicationDidBecomeActive: Observable<UIApplicationState> {
        return NotificationCenter.default.rx
            .notification(UIApplication.didBecomeActiveNotification)
            .map { _ in
                return .active
            }
    }
    
    var applicationDidEnterBackground: Observable<UIApplicationState> {
        return NotificationCenter.default.rx
            .notification(UIApplication.didEnterBackgroundNotification)
            .map { _ in
                return .background
            }
    }
    
    var applicationWillResignActive: Observable<UIApplicationState> {
        return NotificationCenter.default.rx
            .notification(UIApplication.willResignActiveNotification)
            .map { _ in
                return .inactive
            }
    }
    
    var applicationWillTerminate: Observable<UIApplicationState> {
        return NotificationCenter.default.rx
            .notification(UIApplication.willTerminateNotification)
            .map { _ in
                return .terminated
            }
    }
    
    var appState: Observable<UIApplicationState> {
        return Observable.of(
            applicationDidBecomeActive,
            applicationWillResignActive,
            applicationWillEnterForeground,
            applicationDidEnterBackground,
            applicationWillTerminate
        )
        .merge()
    }
}
