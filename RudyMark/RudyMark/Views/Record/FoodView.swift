//
//  APITestView.swift
//  RudyMark
//
//  Created by 이병찬 on 4/5/25.
//
import SwiftUI

struct FoodAPIServiceView: View {
    @StateObject private var viewModel = FoodViewModel()
    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("음식 이름을 입력하세요", text: $searchText)
                        .frame(height: 50)
                        .padding(.horizontal)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // 둥근 사각형 테두리 추가
                                .stroke(Color.gray, lineWidth: 1) // 회색 테두리 적용
                        )
                    
                    Button(action: {
                        viewModel.loadFoods(foodName: searchText)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .padding(8)
                            .foregroundColor(.deepPurple)
                            .background(.lightPurple)
                            .clipShape(Circle())
                    }
                    .padding(.trailing)
                }
                .padding()

                // 📋 결과 리스트
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
            }
            .navigationTitle("음식 기록")
        }
    }
}

#Preview {
    FoodAPIServiceView()
}
