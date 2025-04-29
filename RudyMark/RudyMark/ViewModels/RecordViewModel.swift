//
//  RecordViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 3/31/25.
//

import SwiftUI

class RecordViewModel : ObservableObject {
    @Published var cards: [CardData] = []
    
    init(){
        self.cards = [
            CardData(
                title:"오늘의 식사",
                description: "건강한 하루를 기록해보세요",
                backgroundColor: .white,
                mainTextColor: Color.black,
                subTextColor: Color.gray,
                height: 150,
                MealButtons: [
                    CustomButton(name:"식사 기록하기",
                                 buttonColor: .lightPurple,
                                 icon:"plus",
                                 destination: AnyView(FoodView()))
                ]
            ),
            CardData(
                title:"혈당 측정",
                description: "규칙적인 측정으로 건강을 관리하세요",
                backgroundColor: .white,
                mainTextColor: Color.black,
                subTextColor: Color.gray,
                height: 150,
                MealButtons: [
                    CustomButton(name:"혈당 기록하기",
                                 buttonColor: .red,
                                 icon:"plus",
                                 destination: AnyView(BloodView()))
                ]
            )
        ]
    }
}
