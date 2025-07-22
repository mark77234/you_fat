//
//  CartViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 5/20/25.
//
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var selectedFoods: [Food] = []
    
    func add(_ food: Food) {
        if !selectedFoods.contains(where: { $0.id == food.id }) {
            selectedFoods.append(food)
        }
    }
    
    func remove(_ food: Food) {
        selectedFoods.removeAll { $0.id == food.id }
    }
    
    func clear() {
        selectedFoods.removeAll()
    }
}
