//
//  Food.swift
//  RudyMark
//
//  Created by 이병찬 on 4/7/25.
//
import SwiftUI
import SwiftData

@Model
class Food{
    var name : String
    var calories: String
    
    init(name: String, calories: String) {
        self.name = name
        self.calories = calories
    }
}

@Model
class MealInform {
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
