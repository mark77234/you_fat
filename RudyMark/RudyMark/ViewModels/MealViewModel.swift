//
//  MealViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/2/25.
//

import SwiftUI

// MARK: - ViewModel
class MealViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var allMeals: [MealData] = [
        MealData(name: "현미밥", amount: "1공기", kcal: "330kcal"),
        MealData(name: "닭가슴살", amount: "100g", kcal: "165kcal"),
        MealData(name: "그릭요거트", amount: "130g", kcal: "130kcal"),
        MealData(name: "견과류", amount: "30g", kcal: "160kcal")
    ]
    
    @Published var favoriteMeals: [MealData] = []
    
    var filteredMeals: [MealData] {
        if searchText.isEmpty {
            return allMeals
        } else {
            return allMeals.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func toggleFavorite(_ meal: MealData) {
        if let index = allMeals.firstIndex(where: { $0.id == meal.id }) {
            allMeals[index].isFavorite.toggle()
            updateFavorites()
        }
    }
    
    private func updateFavorites() {
        favoriteMeals = allMeals.filter { $0.isFavorite }
    }
}
