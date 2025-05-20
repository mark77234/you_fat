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
                title:"혈당 기록하기",
                backgroundColor: .white,
                mainTextColor: Color.black,
                subTextColor: Color.gray,
                height: 150,
                MealButtons: [
                    RecordButton(lastBlood:"오늘 측정한 혈당을 포포에게 알려주세요!",
                                 buttonColor: .white,
                                 destination: AnyView(BloodView()))
                ]
            ),
            CardData(
                title:"오늘의 식사",
                backgroundColor: .white,
                mainTextColor: Color.black,
                subTextColor: Color.gray,
                height: 150,
                MealButtons: [
                    RecordButton(name:"아침",
                                 lastDayKcal:"어제 섭취한 칼로리: n kcal",
                                 buttonColor: .grayBackground,
                                 icon: Image(.sun),
                                 destination: AnyView(FoodView())),
                    RecordButton(name:"점심",
                                 lastDayKcal:"어제 섭취한 칼로리: n kcal",
                                 buttonColor: .grayBackground,
                                 icon: Image(.cloud),
                                 destination: AnyView(FoodView())),
                    RecordButton(name:"저녁",
                                 lastDayKcal:"어제 섭취한 칼로리: n kcal",
                                 buttonColor: .grayBackground,
                                 icon: Image(.moon),
                                 destination: AnyView(FoodView())),
                    RecordButton(name:"간식",
                                 lastDayKcal:"어제 섭취한 칼로리: n kcal",
                                 buttonColor: .grayBackground,
                                 icon: Image(.cookie),
                                 destination: AnyView(FoodView()))
                ]
            )
            
        ]
    }
}
