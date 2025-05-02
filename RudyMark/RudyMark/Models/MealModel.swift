//
//  MealModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/2/25.
//

import SwiftUI

struct MealData: Identifiable {
    let id = UUID()
    let name: String
    var amount: String // 개수 및 그람수
    var kcal: String // 칼로리 정보
    var isFavorite: Bool = false
}
