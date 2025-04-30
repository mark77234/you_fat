//
//  Untitled.swift
//  RudyMark
//
//  Created by 이병찬 on 3/31/25.
//

import SwiftUI

struct BloodView: View {
    @StateObject private var viewModel = BloodViewModel()
    @EnvironmentObject var homeViewModel: HomeViewModel
    

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // 혈당 수치 입력 카드
                    BloodCardView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("혈당 수치 (mg/dL)")
                                .font(.headline)
                            TextField("혈당 수치를 입력하세요", text: $viewModel.data.bloodSugar)
                                .keyboardType(.numberPad)
                                .padding()
                                .frame(height: 50)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .padding(.horizontal)
                        }
                    }

                    // 식사 관련 버튼 카드
                    BloodCardView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("식사 관련")
                                .font(.headline)
                            HStack {
                                ForEach(viewModel.mealStates, id: \.self) { state in
                                    Button(action: {
                                        viewModel.data.selectedMealState = state
                                    }) {
                                        Text(state)
                                            .padding(10)
                                            .frame(maxWidth: .infinity)
                                            .background(viewModel.data.selectedMealState == state ? Color.red : Color.gray.opacity(0.3))
                                            .foregroundColor(viewModel.data.selectedMealState == state ? Color.white : Color.black)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        }
                    }

                    BloodCardView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("물 섭취량 (1컵 - 200ml)")
                                .font(.headline)
                            HStack {
                                HStack(spacing: 20) {
                                    Button(action: viewModel.decreaseWater) {
                                        Image(systemName: "minus.circle.fill")
                                            .font(.title)
                                            .foregroundColor(.red)
                                    }
                                    Text("\(viewModel.data.waterIntake) 컵")
                                        .font(.title2)
                                    Button(action: viewModel.increaseWater) {
                                        Image(systemName: "plus.circle.fill")
                                            .font(.title)
                                            .foregroundColor(.blue)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }

                    BloodCardView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("메모")
                                .font(.headline)
                            ZStack(alignment: .topLeading) {
                                if viewModel.data.memo.isEmpty {
                                    Text("메모를 작성하세요")
                                        .foregroundColor(.gray)
                                        .padding(.top, 8)
                                        .padding(.leading, 5)
                                }
                                TextEditor(text: $viewModel.data.memo)
                                    .frame(height: 80)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                            }
                        }
                    }

                    Button(action: {
                        viewModel.saveMeasurement(homeViewModel: homeViewModel)
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("측정 기록하기")
                        }
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                        .padding(.horizontal, 30)
                    }
                }
                .padding(.vertical, 50)
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

struct BloodCardView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal, 30)
    }
}

struct BloodView_Previews: PreviewProvider {
    static var previews: some View {
        BloodView()
    }
}
