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
    var name: String // 이름
    var birth: Date // 생년월일
    var height: Int // 사용자 키
    var weight: Int // 몸무게
    var isMale: Bool // 성별
    var medicationIntervalFromMeal: Double = 0.0
    
    init(name: String, birth: Date, height: Int, weight: Int, isMale: Bool) {
        self.name = name
        self.birth = birth
        self.height = height
        self.weight = weight
        self.isMale = isMale
    }
}




