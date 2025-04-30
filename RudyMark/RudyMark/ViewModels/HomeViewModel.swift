//
//  HomeViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 3/25/25.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    // 카드 데이터 배열
    @Published var cards: [CardData] = []
    
    // 총 영양소 값 추적
    @Published var totalKcal: Double = 0
    @Published var totalCarbs: Double = 0
    @Published var totalProtein: Double = 0
    @Published var totalFat: Double = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupInitialCards()
        setupNutritionBindings()
    }
    
    // 초기 카드 설정
    private func setupInitialCards() {
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
                progress: 0, // 초기값 0
                max: 2000,
                cardCount: 3,
                miniCards: [
                    MiniCard(title: "탄수화물", progress: 0, max: 300, barColor: Color.blue),
                    MiniCard(title: "단백질", progress: 0, max: 100, barColor: Color.red),
                    MiniCard(title: "지방", progress: 0, max: 70, barColor: Color.green)
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
    
    // 영양소 값 변경 관찰 설정
    private func setupNutritionBindings() {
        Publishers.CombineLatest4($totalKcal, $totalCarbs, $totalProtein, $totalFat)
            .sink { [weak self] _ in
                self?.updateNutritionCards()
            }
            .store(in: &cancellables)
    }
    
    // 영양소 카드 업데이트
    private func updateNutritionCards() {
        guard cards.indices.contains(1) else { return }

        var updatedCard = cards[1]
        updatedCard.progress = Float(totalKcal)

        if var miniCards = updatedCard.miniCards, miniCards.count >= 3 {
            miniCards[0].progress = Float(totalCarbs)
            miniCards[1].progress = Float(totalProtein)
            miniCards[2].progress = Float(totalFat)
            updatedCard.miniCards = miniCards
        }

        var newCards = cards
        newCards[1] = updatedCard
        cards = newCards
    }
    
    // 음식 추가 시 호출되는 메서드
    func addFood(_ food: Food) {
        totalKcal += food.kcal
        totalCarbs += food.carbs
        totalProtein += food.protein
        totalFat += food.fat
        updateNutritionCards()
    }

    // 음식 삭제 시 호출되는 메서드
    func removeFood(_ food: Food) {
        totalKcal -= food.kcal
        totalCarbs -= food.carbs
        totalProtein -= food.protein
        totalFat -= food.fat
        updateNutritionCards()
    }
    // 혈당 측정값 배열
    @Published var bloodSugarMeasurements: [Double] = []

    // 혈당 측정값 추가 및 카드 업데이트
    func addBloodSugarMeasurement(_ value: Double) {
        bloodSugarMeasurements.append(value)
        updateBloodSugarCard()
    }

    // 혈당 카드 업데이트
    private func updateBloodSugarCard() {
        guard cards.indices.contains(2) else { return }

        let count = bloodSugarMeasurements.count
        let average = count > 0 ? bloodSugarMeasurements.reduce(0, +) / Double(count) : 0

        var updatedCard = cards[2]
        updatedCard.miniCards = [
            MiniCard(title: "평균혈당", value: String(format: "%.0f mg/dL", average)),
            MiniCard(title: "측정횟수", value: "\(count)회")
        ]

        var newCards = cards
        newCards[2] = updatedCard
        cards = newCards
    }
}
