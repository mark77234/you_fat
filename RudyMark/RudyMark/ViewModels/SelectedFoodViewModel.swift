//
//  SelectedFoodViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/29/25.
//

import Foundation
import SwiftUI

class SelectedFoodsViewModel: ObservableObject {
    @Published var selectedFoods: [Food] = []

    func add(_ food: Food) {
        if !selectedFoods.contains(where: { $0.id == food.id }) {
            selectedFoods.append(food)
        }
    }

    func remove(_ food: Food) {
        selectedFoods.removeAll { $0.id == food.id }
    }
}
