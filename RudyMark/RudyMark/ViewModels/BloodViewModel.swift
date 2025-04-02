//
//  BloodViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/2/25.

import SwiftUI

// ViewModel 정의
class BloodViewModel: ObservableObject {
    @Published var bloodSugar: String = ""
    @Published var selectedMealState: String? = nil
    @Published var waterIntake: Int = 0
    @Published var memo: String = ""

    let mealStates = ["공복", "식전", "식후"]

    func increaseWater() {
        waterIntake += 100
    }

    func decreaseWater() {
        if waterIntake >= 100 {
            waterIntake -= 100
        }
    }

    func saveMeasurement() {
        print("혈당: \(bloodSugar), 식사: \(selectedMealState ?? "선택 안됨"), 물 섭취량: \(waterIntake)ml, 메모: \(memo)")
        // 여기서 데이터 저장 로직 추가 가능
    }
}
