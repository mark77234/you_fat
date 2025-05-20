// FoodView.swift
import SwiftUI
import SwiftData

struct FoodView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var selectedFoodsViewModel: SelectedFoodsViewModel
    
    @State private var foods: [Food] = []
    @State private var searchQuery: String = ""
    @State private var foodToConfirm: Food?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(text: $searchQuery, onSearch: fetchFoods)
                
                Group {
                    if searchQuery.isEmpty {
                        EmptyStateView()
                    } else if foods.isEmpty {
                        NoResultsView(query: searchQuery)
                    } else {
                        FoodListView(foods: foods, onSelect: { foodToConfirm = $0 })
                    }
                }
                
                if !selectedFoodsViewModel.selectedFoods.isEmpty {
                    SelectedFoodsView(
                        selectedFoods: selectedFoodsViewModel.selectedFoods,
                        onRemove: { food in
                            selectedFoodsViewModel.remove(food)
                            homeViewModel.removeFood(food)
                        }
                    )
                }
            }
            .navigationTitle("오늘의 식사")
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
        .alert("음식을 추가할까요?", isPresented: Binding<Bool>(
            get: { foodToConfirm != nil },
            set: { if !$0 { foodToConfirm = nil } }
        )) {
            Button("추가") {
                if let food = foodToConfirm {
                    selectedFoodsViewModel.add(food)
                    homeViewModel.addFood(food)
                }
                foodToConfirm = nil
            }
            Button("취소", role: .cancel) {
                foodToConfirm = nil
            }
        } message: {
            if let food = foodToConfirm {
                Text("\(food.name) (\(food.kcal, specifier: "%.0f")kcal)을 추가합니다.")
            }
        }
    }
    
    private func fetchFoods() {
        guard !searchQuery.isEmpty else { return }
        
        do {
            let descriptor = FetchDescriptor<Food>(
                predicate: #Predicate { $0.name.localizedStandardContains(searchQuery) }
            )
            foods = try context.fetch(descriptor)
        } catch {
            print("🔴 검색 실패: \(error)")
            foods = []
        }
    }
}
