//
//  CSVTestView.swift
//  RudyMark
//
//  Created by 이병찬 on 4/7/25.
//

import SwiftUI
import SwiftData

struct FoodView: View {
    @Environment(\.modelContext) private var context
    @State private var foods: [Food] = []
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Modern search bar with focus indicator
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
                
                // Dynamic content area
                Group {
                    if searchQuery.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "fork.knife.circle")
                                .font(.system(size: 60))
                                .foregroundColor(.purple.opacity(0.3))
                            
                            Text("먹은 음식을 검색해보세요")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxHeight: .infinity)
                    } else if foods.isEmpty {
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
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(foods) { food in
                                    FoodCard(food: food)
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                }
                .transition(.opacity)
            }
            .navigationTitle("오늘의 식사")
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
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

struct FoodCard: View {
    let food: Food
    private var sugarLevel: Color {
        switch food.sugar {
        case ..<5: return .green
        case 5..<10: return .orange
        default: return .red
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                // Sugar indicator with dynamic color
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
            
            // Nutrition grid
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
}
