//
//  Untitled.swift
//  RudyMark
//
//  Created by 이병찬 on 3/31/25.
//

import SwiftUI

// View 정의
struct BloodView: View {
    @StateObject private var viewModel = BloodViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // 혈당 수치 입력 카드
            BloodCardView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("혈당 수치 (mg/dL)")
                        .font(.headline)
                    TextField("혈당 수치를 입력하세요", text: $viewModel.bloodSugar)
                        .padding() // 내부 여백 추가
                        .frame(height: 50) // 입력 칸 높이 조정
                        .background(Color.white) // 배경을 흰색으로 설정
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // 둥근 사각형 테두리 추가
                                .stroke(Color.gray, lineWidth: 1) // 회색 테두리 적용
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
                                viewModel.selectedMealState = state
                            }) {
                                Text(state)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(viewModel.selectedMealState == state ? Color.blue.opacity(0.8) : Color.gray.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }

            // 물 섭취량 조절 카드
            BloodCardView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("물 섭취량 (ml)")
                        .font(.headline)
                    HStack {
                        Button(action: viewModel.decreaseWater) {
                            Image(systemName: "minus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                        }
                        Text("\(viewModel.waterIntake)")
                            .font(.title)
                            .frame(width: 50)
                        Button(action: viewModel.increaseWater) {
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                        }
                    }
                }
            }

            // 메모 입력 카드
            BloodCardView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("메모")
                        .font(.headline)
                    TextEditor(text: $viewModel.memo)
                        .frame(height: 80)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                }
            }

            // 측정 기록 버튼
            Button(action: viewModel.saveMeasurement) {
                HStack {
                    Image(systemName: "plus")
                    Text("측정 기록하기")
                }
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

// 공통 카드 뷰 컴포넌트
struct BloodCardView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

// 프리뷰
struct BloodView_Previews: PreviewProvider {
    static var previews: some View {
        BloodView()
    }
}
