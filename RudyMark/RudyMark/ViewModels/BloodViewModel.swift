//
//  BloodViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/2/25.

import SwiftUI

class BloodViewModel: ObservableObject {
    @Published var data = BloodData()

    func increaseWater() {
        data.waterIntake += 1
    }

    func decreaseWater() {
        if data.waterIntake >= 1 {
            data.waterIntake -= 1
        }
    }

    func saveMeasurement(homeViewModel: HomeViewModel) {
        let bloodSugarValue = data.bloodSugar
        homeViewModel.addBloodSugarMeasurement(bloodSugarValue)
        print("혈당: \(data.bloodSugar), 식사: \(data.selectedMealState ?? "선택 안됨"), 물 섭취량: \(data.waterIntake)ml, 메모: \(data.memo)")
    }
}
