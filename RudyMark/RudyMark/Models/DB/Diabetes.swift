//
//  Diabetes.swift
//  RudyMark
//
//  Created by 이병찬 on 4/7/25.
//
import SwiftUI
import SwiftData

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
