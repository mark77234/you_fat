//
//  model.swift
//  RudyMark
//
//  Created by 트루디 on 3/24/25.
//
import SwiftUI
import SwiftData

@Model
class BodyInform {
    var height: Int // 사용자 키
    var weight: Int // 몸무게
    var isMale: Bool // 성별
    
    init(height: Int, weight: Int, isMale: Bool) {
        self.height = height
        self.weight = weight
        self.isMale = isMale
    }
}

@Model
class Diabetes {
    var pillTime: Date
    var bloodTime: Date
    var measureNum: Int = 0
    
    init(pillTime: Date, bloodTime: Date, measureNum: Int) {
        self.pillTime = pillTime
        self.bloodTime = bloodTime
        self.measureNum = measureNum
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
