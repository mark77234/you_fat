//
//  FoodViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/5/25.
//
import SwiftUI

class FoodViewModel: ObservableObject {
    @Published var foods: [FoodData] = []
    private let apiService = FoodAPIService()

    func loadFoods(foodName: String) {
        apiService.fetchNutrition(foodName:foodName) { [weak self] items in
            self?.foods = items
        }
    }
}
