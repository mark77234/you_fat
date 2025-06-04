//
//  FoodDetailView.swift
//  RudyMark
//
//  Created by 이병찬 on 6/4/25.
//

import SwiftUI
import SwiftData

// 음식 상세 정보 뷰 추가
struct FoodDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartViewModel: CartViewModel
    let food: Food
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 음식 기본 정보
                VStack(alignment: .leading, spacing: 8) {
                    Text(food.name)
                        .font(.title.bold())
                    
                    HStack {
                        NutritionInfoView(value: food.kcal, unit: "kcal", label: "칼로리")
                        NutritionInfoView(value: food.carbs, unit: "g", label: "탄수화물")
                        NutritionInfoView(value: food.protein, unit: "g", label: "단백질")
                        NutritionInfoView(value: food.fat, unit: "g", label: "지방")
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                
                // 상세 영양 정보
                VStack(alignment: .leading, spacing: 12) {
                    Text("영양 성분")
                        .font(.headline)
                    
                    NutritionDetailRow(label: "당류", value: food.sugar, unit: "g")
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                
                Spacer()
                
                // 장바구니 추가 버튼
                Button(action: {
                    cartViewModel.add(food)
                    dismiss()
                }) {
                    Text("장바구니에 추가")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("음식 정보")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("닫기") {
                    dismiss()
                }
            }
        }
    }
}

// 영양 정보 표시 뷰
struct NutritionInfoView: View {
    let value: Double
    let unit: String
    let label: String
    
    var body: some View {
        VStack {
            Text("\(value, specifier: "%.0f")\(unit)")
                .font(.headline)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// 영양 상세 정보 행
struct NutritionDetailRow: View {
    let label: String
    let value: Double
    let unit: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text("\(value, specifier: "%.1f") \(unit)")
                .foregroundColor(.secondary)
        }
    }
}

