//
//  FoodViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/5/25.
//
import SwiftUI

class FoodViewModel: ObservableObject {
    @Published var foods: [NutriItem] = []
    private let apiService = FoodAPIService()

    func loadFoods() {
        apiService.fetchNutrition(foodName:"바나나") { [weak self] items in
            self?.foods = items
        }
    }
}
