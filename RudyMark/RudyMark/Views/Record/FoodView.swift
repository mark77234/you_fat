//
//  CSVTestView.swift
//  RudyMark
//
//  Created by 이병찬 on 4/7/25.
//

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
            VStack {
                HStack {
                    TextField("식사하신 음식을 입력해주세요", text: $searchQuery)
                        .padding() // 내부 여백 추가
                        .frame(height: 50) // 입력 칸 높이 조정
                        .background(Color.white) // 배경을 흰색으로 설정
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // 둥근 사각형 테두리 추가
                                .stroke(Color.gray, lineWidth: 1) // 회색 테두리 적용
                        )
                        .padding(.horizontal)
                    
                    Button(action: {
                        fetchFoods()
                    }) {
                        Image(systemName: "magnifyingglass")
                                .font(.system(size: 16, weight: .bold))
                                .padding(10)
                                .background(.purpleBackground)
                                .foregroundColor(.deepPurple)
                                .clipShape(Circle())
                    }
                    .padding(.trailing)
                }
                .padding(.top)
                
                if searchQuery.isEmpty {
                    Spacer()
                    Text("음식 이름을 검색해보세요")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    if foods.isEmpty {
                        Spacer()
                        Text("검색 결과가 없습니다.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        List(foods) { food in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(food.name)
                                    .font(.headline)
                                
                                HStack {
                                    Text("칼로리: \(food.kcal, specifier: "%.1f") kcal")
                                    Spacer()
                                    Text("탄수화물: \(food.carbs, specifier: "%.1f") g")
                                }
                                .font(.subheadline)
                                
                                HStack {
                                    Text("단백질: \(food.protein, specifier: "%.1f") g")
                                    Spacer()
                                    Text("지방: \(food.fat, specifier: "%.1f") g")
                                }
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("식품 검색")
        }
    }
    
    private func fetchFoods() {
        guard !searchQuery.isEmpty else {
            foods = []
            return
        }
        
        do {
            // 검색어에 해당하는 식품명만 가져오기
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

#Preview{
    FoodView()
}
