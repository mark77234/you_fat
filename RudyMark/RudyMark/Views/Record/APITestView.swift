//
//  APITestView.swift
//  RudyMark
//
//  Created by 이병찬 on 4/5/25.
//
import SwiftUI

struct FoodAPIServiceView: View {
    @StateObject private var viewModel = FoodViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.foods) { food in
                VStack(alignment: .leading, spacing: 6) {
                    Text(food.foodNm ?? "이름 없음")
                        .font(.headline)
                    
                    HStack {
                        Text("칼로리: \(food.enerc ?? "-")kcal")
                        Spacer()
                        Text("탄수화물: \(food.chocdf ?? "-")g")
                        Spacer()
                        Text("단백질: \(food.prot ?? "-")g")
                        Spacer()
                        Text("지방: \(food.fatce ?? "-")g")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("영양 정보")
            .onAppear {
                viewModel.loadFoods()
            }
        }
    }
}

#Preview{
    FoodAPIServiceView()
}
