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




