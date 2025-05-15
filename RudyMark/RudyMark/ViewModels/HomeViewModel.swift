//
//  HomeViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 3/25/25.
//

import SwiftUI
import Combine
import SwiftData

class HomeViewModel: ObservableObject {
    // 카드 데이터 배열
    @Published var cards: [CardData] = []
    @Published var bloodDataList: [BloodData] = []
    
    // 총 영양소 값 추적
    @Published var totalKcal: Double = 0
    @Published var totalCarbs: Double = 0
    @Published var totalProtein: Double = 0
    @Published var totalFat: Double = 0
    
    private var cancellables = Set<AnyCancellable>()
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        setupInitialCards()
        setupNutritionBindings()
        loadPersistedFoods()
        loadBloodData()
    }
    
    private func getUserName() -> String {
            guard let data = UserDefaults.standard.data(forKey: "savedUser"),
                  let user = try? JSONDecoder().decode(User.self, from: data),
                  !user.name.isEmpty else {
                return "회원" // 기본값
            }
            return user.name
        }

    
    // 초기 카드 설정
    private func setupInitialCards() {
        let userName = getUserName()

        self.cards = [
            CardData(
                cardIcon:"popo",
                main_title:"\(userName)님 안녕하세요 !",
                description: "오늘의 칼로리 및 혈당수치를 확인하세요.",
                backgroundColor: .grayBackground,
                mainTextColor: Color.black,
                subTextColor: Color.gray,
                height: 100
            ),
            CardData(
                title:"최근 혈당 측정값",
                blood_count:0,
                backgroundColor: Color.white,
                mainTextColor: Color.black,
                subTextColor: Color.black,
                height: 110,
                stat:"미측정",
                blood_progress: 0,
                blood_progress_color: .deepPurple,
                max: 200,
                miniCardsColor: .lightRed,
                miniCardsSize: 80
            ),
            CardData(
                title:"오늘 섭취한 칼로리",
                description: nil,
                backgroundColor: Color.white,
                mainTextColor: Color.black,
                subTextColor: Color.black,
                height: 150,
                progress: 0, // 초기값 0
                max: 2000,
                cardCount: 3,
                miniCards: [
                    MiniCard(title: "탄수화물", progress: 0, max: 300, barColor: .blueBar),
                    MiniCard(title: "단백질", progress: 0, max: 100, barColor: .greenBar),
                    MiniCard(title: "지방", progress: 0, max: 70, barColor: .yellowBar)
                ],
                miniCardsColor: Color.white,
                miniCardsSize: 50
            )
        ]
    }
    func loadBloodData() {
            do {
                let descriptor = FetchDescriptor<BloodData>()
                bloodDataList = try modelContext.fetch(descriptor)
                updateBloodSugarCard()
            } catch {
                print("혈당 데이터 로드 실패: \(error)")
            }
        }
    
    func loadPersistedFoods() {
            do {
                let descriptor = FetchDescriptor<Food>(
                            predicate: #Predicate { $0.isUserAdded} // 사용자 음식만
                        )
                let persistedFoods = try modelContext.fetch(descriptor)
                
                persistedFoods.forEach { food in
                    totalKcal += food.kcal
                    totalCarbs += food.carbs
                    totalProtein += food.protein
                    totalFat += food.fat
                }
                
                updateNutritionCards()
            } catch {
                print("Failed to load persisted foods: \(error)")
            }
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

        var updatedCard = cards[2]
        updatedCard.progress = Float(totalKcal)

        if var miniCards = updatedCard.miniCards, miniCards.count >= 3 {
            miniCards[0].progress = Float(totalCarbs)
            miniCards[1].progress = Float(totalProtein)
            miniCards[2].progress = Float(totalFat)
            updatedCard.miniCards = miniCards
        }

        var newCards = cards
        newCards[2] = updatedCard
        cards = newCards
    }
    
    // 음식 추가 시 호출되는 메서드
    func addFood(_ food: Food) {
        food.isUserAdded = true
        modelContext.insert(food)
            do {
                try modelContext.save()
            } catch {
                print("Error saving food: \(error)")
            }
        totalKcal += food.kcal
        totalCarbs += food.carbs
        totalProtein += food.protein
        totalFat += food.fat
        updateNutritionCards()
    }

    // 음식 삭제 시 호출되는 메서드
    func removeFood(_ food: Food) {
        modelContext.delete(food)
            do {
                try modelContext.save()
            } catch {
                print("Error deleting food: \(error)")
            }
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
            let newData = BloodData(
                bloodSugar: value,
                selectedMealState: nil,
                waterIntake: 0,
                memo: ""
            )
            modelContext.insert(newData)
            do {
                try modelContext.save()
                bloodDataList.append(newData) // 로컬 데이터 업데이트
                updateBloodSugarCard()
            } catch {
                print("혈당 데이터 저장 실패: \(error)")
            }
        }

    func removeBloodSugarMeasurement(at offsets: IndexSet) {
           offsets.forEach { index in
               let data = bloodDataList[index]
               modelContext.delete(data)
           }
           do {
               try modelContext.save()
               bloodDataList.remove(atOffsets: offsets) // 로컬 데이터 업데이트
               updateBloodSugarCard()
           } catch {
               print("혈당 데이터 삭제 실패: \(error)")
           }
       }

    // 혈당 카드 업데이트
    private func updateBloodSugarCard() {
        let measurements = bloodDataList.map { $0.bloodSugar }
        let count = measurements.count
        let recent = measurements.last ?? 0
                
        guard cards.indices.contains(1) else { return }
        
        var updatedCard = cards[1]
        updatedCard.blood_progress = Float(recent)
        updatedCard.max = 200
        updatedCard.blood_count = count

        if recent < 100 {
            updatedCard.stat = "낮음"
            updatedCard.blood_progress_color = Color.blue
        } else if recent < 150 {
            updatedCard.stat = "정상"
            updatedCard.blood_progress_color = .deepPurple
        } else {
            updatedCard.stat = "높음"
            updatedCard.blood_progress_color = Color.red
        }

        var newCards = cards
        newCards[1] = updatedCard
        cards = newCards
    }
}

extension HomeViewModel {
    func resetDailyData() {
        // 영양소 총합 초기화
        totalKcal = 0
        totalCarbs = 0
        totalProtein = 0
        totalFat = 0
        
        // 혈당 데이터 초기화
        bloodDataList.removeAll()
        
        // 카드 UI 업데이트
        updateNutritionCards()
        updateBloodSugarCard()
    }
}
