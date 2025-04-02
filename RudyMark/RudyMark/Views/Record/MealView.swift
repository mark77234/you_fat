//
//  MealView.swift
//  RudyMark
//
//  Created by 이병찬 on 3/31/25.
//

import SwiftUI

struct MealView: View {
    @StateObject private var viewModel = MealViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("음식 검색")
                    .font(.system(size:25, weight: .bold))
                
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("식사 검색...", text: $viewModel.searchText)
                .padding() // 내부 여백 추가
                .frame(height: 50) // 입력 칸 높이 조정
                .background(Color.white) // 배경을 흰색으로 설정
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // 둥근 사각형 테두리 추가
                        .stroke(Color.gray, lineWidth: 1) // 회색 테두리 적용
                )
                .padding(.horizontal)
            
            
            
            List(viewModel.filteredMeals) { meal in
                HStack {
                    Button(action: {
                        viewModel.toggleFavorite(meal)
                    }) {
                        Image(systemName: meal.isFavorite ? "star.fill" : "star")
                            .foregroundColor(meal.isFavorite ? .yellow : .gray)
                    }
                    VStack(alignment: .leading) {
                        
                        Text(meal.name)
                            .font(.headline)
                        Text(meal.amount)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(meal.kcal)
                        .font(.subheadline)
                        .foregroundColor(.orange)
                    
                }
                .padding(.vertical, 5)
            }
        }
    }
}


#Preview {
    MealView()
}
