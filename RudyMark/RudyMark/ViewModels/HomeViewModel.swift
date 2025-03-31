//
//  HomeViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 3/25/25.
//

import SwiftUI

class HomeViewModel : ObservableObject {
    @Published var cards: [CardData] = []
    
    init(){
        self.cards = [
            CardData(
                title:"안녕하세요 !",
                description: "오늘의 칼로리 및 혈당수치를 확인하세요.",
                backgroundColor: Color.white,
                mainTextColor: Color.black,
                subTextColor: Color.gray,
                height: 100
            ),
            CardData(
                title:"오늘의 칼로리",
                description: nil,
                backgroundColor: Color.white,
                mainTextColor: Color.black,
                subTextColor: Color.black,
                height: 150,
                progress: 1600, // 현재 식사한 칼로리
                max: 2000,
                cardCount: 3,
                miniCards: [
                    MiniCard(title: "탄수화물", progress: 250, max: 300,barColor: Color.blue),
                    MiniCard(title: "단백질", progress: 80, max: 100,barColor: Color.red),
                    MiniCard(title: "지방", progress: 50, max: 70,barColor: Color.green)
                            ],
                miniCardsColor: .skyblue,
                miniCardsSize: 100
            ),
            CardData(
                title:"오늘의 평균혈당",
                backgroundColor: Color.white,
                mainTextColor: Color.black,
                subTextColor: Color.black,
                height: 110,
                miniCards:[
                    MiniCard(title:"평균혈당",value:"126 mg/dL"),
                    MiniCard(title:"측정횟수",value:"3회")
                ],
                miniCardsColor: .lightRed,
                miniCardsSize: 80
            ),
            CardData(
                title:"오늘의 조언",
                description: "혈당 관리를 위해 저녁 식사에는 탄수화물 섭취를 줄이고 단백질과 채소 위주로 드시는 것이 좋습니다.",
                backgroundColor: .skyblue,
                mainTextColor: .deepBlue,
                subTextColor: .deepBlue,
                height: 110
            )
        ]
    }
}
