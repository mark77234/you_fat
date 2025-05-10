//
//  BloodModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/2/25.
//


import SwiftUI
import SwiftData

@Model
final class BloodData {
    var bloodSugar: Double
    var selectedMealState: String?
    var waterIntake: Int
    var memo: String

    init(
        bloodSugar: Double = 0.0,
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
