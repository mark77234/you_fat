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
    @Query var foods: [Food]  // SwiftData에서 Food 모델 전체 불러오기

    var body: some View {
        NavigationView {
            List(foods.prefix(10)) { food in
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
            .navigationTitle("CSV 식품 리스트")
        }
    }
}

#Preview
{
    CSVTestView()
}
