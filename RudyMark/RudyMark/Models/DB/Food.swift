//
//  Food.swift
//  RudyMark
//
//  Created by 이병찬 on 4/7/25.
//
import SwiftUI
import SwiftData

@Model
final class Food {
    var name: String
    var kcal: Double
    var carbs: Double
    var protein: Double
    var fat: Double
    var sugar: Double
    var isUserAdded: Bool

    init(name: String, kcal: Double, carbs: Double, protein: Double, fat: Double, sugar: Double,isUserAdded: Bool = false) {
        self.name = name
        self.kcal = kcal
        self.carbs = carbs
        self.protein = protein
        self.fat = fat
        self.sugar = sugar
        self.isUserAdded = isUserAdded
    }
}

final class MealInform {
    var dayCalories: Int // 일일 권장 칼로리
    var currentCalories: Int // 현재 섭취한 칼로리
    var carbohydrate: Int // 탄수화물
    var protein: Int // 단백질
    var fat: Int // 지방
    
    init(dayCalories: Int, currentCalories: Int, carbohydrate: Int, protein: Int, fat: Int) {
        self.dayCalories = dayCalories
        self.currentCalories = currentCalories
        self.carbohydrate = carbohydrate
        self.protein = protein
        self.fat = fat
    }
}
