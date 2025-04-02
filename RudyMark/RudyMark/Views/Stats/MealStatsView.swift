//
//  MealStatsView.swift
//  RudyMark
//
//  Created by 트루디 on 3/31/25.
//

import SwiftUI
import Charts

struct MealStatsView: View {
    
    let weeklyCalories: [(day: String, calories: Int)] = [
        ("월", 2000), ("화", 1800), ("수", 2200), ("목", 1900),
        ("금", 2100), ("토", 2300), ("일", 1950)
    ]
    let width_1 = 26/393 * UIScreen.main.bounds.width
    
    var body: some View {
        
        ZStack {
            Color.grayBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .center) {
                    VStack(spacing: 16) {
                        HStack {
                            Text("칼로리 섭취량")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.leading)
                            Spacer()
                        }
                        .padding(.top)
                        
                        Chart {
                            ForEach(weeklyCalories, id: \.day) { data in
                                BarMark(
                                    x: .value("요일", data.day),
                                    y: .value("칼로리", data.calories),
                                    width: MarkDimension(floatLiteral: width_1)
                                )
                                .foregroundStyle(.green)
                            }
                        }
                        .padding()
                        .frame(width: 343/393 * UIScreen.main.bounds.width, height: 332/852 * UIScreen.main.bounds.height)
                        
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.white)
                    )
                    .padding(.horizontal)


                    
                    VStack(spacing: 16) {
                        HStack {
                            StatBox(title: "평균 칼로리", value: "1971 kcal", color: .skyblue)
                            StatBox(title: "평균 탄수화물", value: "240 g", color: .lightGreen)
                        }
                        HStack {
                            StatBox(title: "평균 단백질", value: "102 g", color: .lightYellow)
                            StatBox(title: "평균 지방", value: "63 g", color: .lightRed)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.white)
                    )

                    
                    AnalysisView(text: "이번 주 탄수화물 섭취량이 목표보다 약간 높습니다. 저녁 식사에서 탄수화물 섭취를 줄이고 단백질 섭취를 늘리는 것이 좋습니다.")
                }
                .padding()
            }
        }
    }
}

#Preview {
    MealStatsView()
}
