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
    var timestamp: Date

    init(
        bloodSugar: Double = 0.0,
        selectedMealState: String? = nil,
        waterIntake: Int = 0,
        timestamp: Date = Date(),
        memo: String = ""
    ) {
        self.bloodSugar = bloodSugar
        self.selectedMealState = selectedMealState
        self.waterIntake = waterIntake
        self.memo = memo
        self.timestamp = timestamp
    }
}
