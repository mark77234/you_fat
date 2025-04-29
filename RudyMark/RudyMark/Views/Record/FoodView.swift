//
//  CSVTestView.swift
//  RudyMark
//
//  Created by 이병찬 on 4/7/25.
//

// FoodView.swift
// 음식 데이터를 검색하고 결과를 표시하는 SwiftData 기반 뷰

import SwiftUI
import SwiftData

struct FoodView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var foods: [Food] = []
    @State private var searchQuery: String = ""
    @State private var selectedFoods: [Food] = []
    @State private var foodToConfirm: Food?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 검색 바
                HStack(spacing: 12) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        
                        TextField("음식 이름 검색", text: $searchQuery)
                            .submitLabel(.search)
                            .onSubmit { fetchFoods() }
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 2, y: 1)
                    )
                    
                    if !searchQuery.isEmpty {
                        Button("취소") {
                            searchQuery = ""
                            foods = []
                        }
                        .transition(.opacity)
                    }
                }
                .padding()
                .animation(.easeInOut, value: searchQuery)
                
                // 검색 결과 영역
                Group {
                    if searchQuery.isEmpty {
                        emptyStateView
                    } else if foods.isEmpty {
                        noResultsView
                    } else {
                        foodListView
                    }
                }
                .transition(.opacity)
                
                // 선택한 음식 목록
                if !selectedFoods.isEmpty {
                    selectedFoodsView
                }
            }
            .navigationTitle("오늘의 식사")
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
        .alert("음식을 추가할까요?", isPresented: Binding<Bool>(
            get: { foodToConfirm != nil },
            set: { if !$0 { foodToConfirm = nil } }
        )) {
            Button("추가", role: .none) {
                if let food = foodToConfirm {
                    selectedFoods.append(food)
                    homeViewModel.addFood(food) // HomeViewModel에 음식 정보 전달
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
    
    // 빈 상태 뷰
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 60))
                .foregroundColor(.purple.opacity(0.3))
            
            Text("먹은 음식을 검색해보세요")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxHeight: .infinity)
    }
    
    // 검색 결과 없음 뷰
    private var noResultsView: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.orange.opacity(0.3))
            
            Text("'\(searchQuery)'에 대한\n검색 결과가 없습니다")
                .font(.headline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxHeight: .infinity)
    }
    
    // 음식 목록 뷰
    private var foodListView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(foods) { food in
                    FoodCard(food: food) {
                        foodToConfirm = food
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
    
    // 선택한 음식 목록 뷰
    private var selectedFoodsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Divider()
                .padding(.horizontal)
            Text("선택한 음식")
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(selectedFoods) { food in
                HStack {
                    VStack(alignment: .leading) {
                        Text(food.name)
                            .font(.subheadline)
                        Text("\(food.kcal, specifier: "%.0f")kcal | 탄수 \(food.carbs, specifier: "%.1f")g 단백 \(food.protein, specifier: "%.1f")g 지방 \(food.fat, specifier: "%.1f")g")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button(action: {
                        if let index = selectedFoods.firstIndex(where: { $0.id == food.id }) {
                            selectedFoods.remove(at: index)
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
        }
        .padding(.top)
    }
    
    // 음식 데이터 검색
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

// 음식 카드 뷰
struct FoodCard: View {
    let food: Food
    let onTap: () -> Void
    
    private var sugarLevel: Color {
        switch food.sugar {
        case ..<5: return .green
        case 5..<10: return .orange
        default: return .red
        }
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    // 당 수치 표시기
                    VStack(spacing: 4) {
                        Text("당")
                            .font(.caption2)
                            .foregroundColor(.white)
                        
                        Text("\(food.sugar, specifier: "%.1f")g")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding(8)
                    .frame(minWidth: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(sugarLevel.gradient)
                    )
                    
                    // 음식 기본 정보
                    VStack(alignment: .leading, spacing: 4) {
                        Text(food.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("\(food.kcal, specifier: "%.0f")kcal")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                
                // 영양소 그리드
                HStack {
                    NutritionBadge(value: food.carbs, unit: "g", label: "탄수", color: .purple)
                    NutritionBadge(value: food.protein, unit: "g", label: "단백", color: .blue)
                    NutritionBadge(value: food.fat, unit: "g", label: "지방", color: .orange)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
            )
        }
    }
}

// 영양소 배지 뷰
struct NutritionBadge: View {
    let value: Double
    let unit: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 2) {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text("\(value, specifier: "%.1f")")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                
                Text(unit)
                    .font(.system(size: 10))
            }
            .foregroundColor(color)
            
            Text(label)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.secondary)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemFill), lineWidth: 1)
        )
    }
}

#Preview {
    FoodView()
        .environmentObject(HomeViewModel())
}
