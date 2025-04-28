//
//  NavigationRouter.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//

import SwiftUI

// 1️⃣ 라우터: 화면 이동을 관리하는 ObservableObject
class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func setStack(_ screens: [Screen]) {
        var newPath = NavigationPath()
        for screen in screens {
            newPath.append(screen)
        }
        path = newPath
    }
}

// 2️⃣ 화면 식별을 위한 Enum
enum Screen: Hashable {
    case InputBody
    case InputBloodTime
    case InputGender
    case InputPillTime
    case Home
}

