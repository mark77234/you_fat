//
//  BloodViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/2/25.

import SwiftUI

class BloodViewModel: ObservableObject {
    @Published var data = BloodData()

    let mealStates = ["공복", "식전", "식후"]

    func increaseWater() {
        data.waterIntake += 1
    }

    func decreaseWater() {
        if data.waterIntake >= 1 {
            data.waterIntake -= 1
        }
    }

    func saveMeasurement(homeViewModel: HomeViewModel) {
        if let bloodSugarValue = Double(data.bloodSugar) {
            homeViewModel.addBloodSugarMeasurement(bloodSugarValue)
        } else {
            print("⚠️ 유효하지 않은 혈당 입력값입니다: \(data.bloodSugar)")
        }

        print("혈당: \(data.bloodSugar), 식사: \(data.selectedMealState ?? "선택 안됨"), 물 섭취량: \(data.waterIntake)ml, 메모: \(data.memo)")
    }
}
