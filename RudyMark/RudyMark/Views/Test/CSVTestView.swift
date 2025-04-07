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

struct CSVTestView: View {
    @Environment(\.modelContext) private var context
    @State private var foods: [Food] = []
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("음식 검색", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        fetchFoods()
                    }) {
                        Text("검색")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
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
