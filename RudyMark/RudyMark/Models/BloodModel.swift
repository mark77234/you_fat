//
//  BloodModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/2/25.
//


import SwiftUI

struct BloodData {
    var bloodSugar: String
    var selectedMealState: String?
    var waterIntake: Int
    var memo: String

    // 기본값이 있는 생성자 추가 ✅
    init(
        bloodSugar: String = "",
        selectedMealState: String? = nil,
        waterIntake: Int = 0,
        memo: String = ""
    ) {
        self.bloodSugar = bloodSugar
        self.selectedMealState = selectedMealState
        self.waterIntake = waterIntake
        self.memo = memo
    }
}
