//
//  FoodModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/5/25.
//
import SwiftUI

struct FoodData: Codable, Identifiable {
    var id: UUID { UUID() }
    let foodNm: String?
    let enerc: String?
    let prot: String?
    let fatce: String?
    let chocdf: String?
}
