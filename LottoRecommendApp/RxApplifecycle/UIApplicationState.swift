//
//  UIApplicationState.swift
//
//
//  Created by jun wook on 3/22/24.
//

import Foundation

public enum UIApplicationState {
    /// 앱이 실제 실행중이고 사용자 이벤트를 받아서 상호작용할 수 있는 상태
    case active
    /// 앱이 실행중이지만 사용자로부터 이벤트를 받을 수 없는 상태
    case inactive
    /// 앱이 백그라운드에 있는 상태
    case background
    /// 앱 종료 되는 상태
    case terminated
}
